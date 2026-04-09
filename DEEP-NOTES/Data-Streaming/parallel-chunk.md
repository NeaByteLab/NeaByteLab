---
title: 'Parallel Chunk'
source: 'https://developer.mozilla.org/en-US/docs/Web/API/Streams_API'
description: 'Sending multiple chunks simultaneously for throughput. Needs sequence numbers and reassembly buffer.'
tags:
  - 'streaming'
  - 'network'
  - 'parallel'
  - 'patterns'
---

# Parallel Chunk

## Overview

This note covers **parallel chunk streaming**: transmitting multiple data chunks simultaneously over separate streams or connections. Chunks may arrive out of order and must be reassembled using sequence numbers. The trade-off is higher throughput at the cost of complexity and memory overhead for buffering and reordering. **Goal:** recognize when chunks are independent and throughput matters more than immediate ordering, and implement proper reassembly without data loss.

## Definition

**Parallel chunk streaming** means dividing data into chunks, assigning explicit sequence numbers, and transmitting them simultaneously over multiple streams or connections. Chunks may complete at different times and arrive out of order. The receiver buffers out-of-order chunks and reassembles them into the correct sequence before delivery to the application.

Key properties:

- Multiple streams or connections carry chunks concurrently
- Explicit sequence numbers required for reassembly
- Receiver needs buffer to hold out-of-order chunks
- Higher throughput by bypassing head-of-line blocking
- Complex state management for tracking and reordering

## The Analogy

**Parallel streaming is like multiple checkout lanes at a grocery store.** Shoppers (chunks) spread across lanes (streams) and check out simultaneously. Some finish faster than others. You collect receipts (sequence numbers) to know who came in which order. A staging area (buffer) holds shoppers who finished early until their predecessors arrive. More throughput, but requires organization space and coordination to ensure people exit in the right sequence.

## When You See It

Parallel streaming appears when:

- Throughput is the bottleneck rather than latency
- Chunks are independent and order does not matter for individual processing
- You can tolerate reassembly complexity and memory overhead for buffering
- The protocol supports multiplexing (HTTP/2, HTTP/3, QUIC) or multiple connections

Common scenarios:

- **File upload resumption**: upload multiple parts simultaneously, resume failed chunks
- **CDN content delivery**: fetch file chunks from edge servers in parallel
- **Bulk data transfer**: database dumps, log files, backups where speed matters
- **Download accelerators**: split file into chunks, download from multiple sources
- **HTTP/2 server push**: multiple resource streams in parallel

## Examples

**Good: Parallel file upload with reassembly**

```typescript
/**
 * File chunk with sequence metadata.
 * @description Chunk for parallel upload with checksum.
 */
interface FileChunk {
  /** Chunk sequence number */
  sequence: number
  /** Chunk binary data */
  data: Blob
  /** Chunk checksum for integrity */
  checksum: string
}

/**
 * Upload files with parallel chunks.
 * @description Splits files and uploads chunks concurrently.
 */
class ParallelFileUploader {
  /** Array of file chunks */
  private chunks: FileChunk[] = []
  /** Maximum concurrent uploads */
  private maxParallelChunks = 4

  /**
   * Initialize uploader with file.
   * @description Creates chunks from file for upload.
   * @param file - File to upload
   * @param chunkSize - Size per chunk in bytes
   */
  constructor(file: File, chunkSize: number) {
    this.chunks = this.createChunks(file, chunkSize)
  }

  /** Upload chunks with limited concurrency */
  async upload(): Promise<void> {
    const semaphore = new Semaphore(this.maxParallelChunks)
    const uploadPromises = this.chunks.map(chunk =>
      semaphore.acquire().then(() => this.uploadChunk(chunk).finally(() => semaphore.release()))
    )
    await Promise.all(uploadPromises)
    await this.signalComplete()
  }

  /**
   * Upload single chunk independently.
   * @description No waiting for other chunks.
   * @param chunk - File chunk to upload
   */
  private async uploadChunk(chunk: FileChunk): Promise<void> {
    const formData = new FormData()
    formData.append('sequence', String(chunk.sequence))
    formData.append('data', chunk.data)
    formData.append('checksum', chunk.checksum)
    await fetch('/upload-chunk', {
      method: 'POST',
      body: formData
    })
  }

  /** Signal completion to server */
  private signalComplete(): Promise<void> {
    return fetch('/upload-complete', {
      method: 'POST',
      body: JSON.stringify({ totalChunks: this.chunks.length })
    })
  }
}

/**
 * Server-side chunk reassembly buffer.
 * @description Buffers chunks and reassembles in order.
 */
class ChunkReassembler {
  /** Buffer map of sequence to data */
  private buffers = new Map<number, Buffer>()
  /** Set of received sequence numbers */
  private receivedSequences = new Set<number>()

  /**
   * Buffer chunk by sequence number.
   * @description Stores chunk for later reassembly.
   * @param sequence - Chunk sequence number
   * @param data - Chunk buffer data
   */
  storeChunk(sequence: number, data: Buffer): void {
    this.buffers.set(sequence, data)
    this.receivedSequences.add(sequence)
  }

  /**
   * Verify all chunks received.
   * @description Missing chunks block reassembly.
   * @param totalChunks - Expected total chunk count
   * @returns True if all chunks received
   */
  canReassemble(totalChunks: number): boolean {
    return this.receivedSequences.size === totalChunks
  }

  /**
   * Reconstruct original chunk order.
   * @description Iterates 0..totalChunks-1 to rebuild file.
   * @param totalChunks - Total number of chunks
   * @returns Reassembled buffer
   */
  reassemble(totalChunks: number): Buffer {
    const ordered: Buffer[] = []
    for (let i = 0; i < totalChunks; i++) {
      ordered.push(this.buffers.get(i)!)
    }
    return Buffer.concat(ordered)
  }
}
```

**Good: Download accelerator with parallel chunks**

```typescript
/**
 * Download chunk with byte range.
 * @description Defines byte range for parallel download.
 */
interface DownloadChunk {
  /** Start byte position */
  start: number
  /** End byte position */
  end: number
  /** Chunk index for reassembly */
  index: number
}

/**
 * Download accelerator with parallel chunks.
 * @description Uses HTTP Range requests for concurrent download.
 */
class ParallelDownloader {
  /** File URL for download */
  private url: string
  /** Size per chunk in bytes */
  private chunkSize: number
  /** Maximum concurrent downloads */
  private maxConcurrency: number

  /**
   * Initialize downloader with URL.
   * @description Sets URL, chunk size, and concurrency.
   * @param url - File URL to download
   * @param chunkSize - Size per chunk in bytes
   */
  constructor(url: string, chunkSize: number = 1024 * 1024) {
    this.url = url
    this.chunkSize = chunkSize
    this.maxConcurrency = 6
  }

  /**
   * Download all chunks in parallel.
   * @description Uses HTTP Range requests concurrently.
   * @returns Reassembled file buffer
   */
  async download(): Promise<Buffer> {
    const fileSize = await this.getFileSize()
    const chunks = this.calculateChunks(fileSize)
    const downloadedChunks = await Promise.all(chunks.map(chunk => this.downloadChunk(chunk)))
    return this.reassembleChunks(downloadedChunks)
  }

  /**
   * Download specific byte range.
   * @description Uses HTTP Range request header.
   * @param chunk - Download chunk with byte range
   * @returns Chunk with index and data
   */
  private async downloadChunk(chunk: DownloadChunk): Promise<{ index: number; data: Buffer }> {
    const response = await fetch(this.url, {
      headers: { Range: `bytes=${chunk.start}-${chunk.end}` }
    })
    const data = Buffer.from(await response.arrayBuffer())
    return { index: chunk.index, data }
  }

  /**
   * Sort chunks by index and concatenate.
   * @description Restores correct order before concatenation.
   * @param chunks - Array of downloaded chunks
   * @returns Reassembled buffer
   */
  private reassembleChunks(chunks: { index: number; data: Buffer }[]): Buffer {
    const sorted = chunks.sort((a, b) => a.index - b.index)
    return Buffer.concat(sorted.map(c => c.data))
  }
}
```

**Bad: Parallel when order is critical**

```typescript
/**
 * Parallel token streaming with ordering issues.
 * @description Tokens may arrive unordered.
 */
class BrokenTokenStreamer {
  /**
   * Fire all tokens simultaneously.
   * @description Incorrect approach without order control.
   * @param prompt - Input prompt
   */
  async streamTokens(prompt: string): Promise<void> {
    const tokenPromises = this.generateTokens(prompt).map(token => this.sendToken(token))
    await Promise.all(tokenPromises)
  }

  /**
   * Send single token to client now.
   * @description Multiple calls in parallel.
   * @param token - Token to send
   */
  private async sendToken(token: Token): Promise<void> {
    await fetch('/token', {
      method: 'POST',
      body: JSON.stringify(token)
    })
  }
}

/**
 * Better: Sequential token streaming.
 * @description Preserves order with sequential delivery.
 */
class CorrectTokenStreamer {
  /**
   * Stream tokens one at a time.
   * @description Preserves generation order.
   * @param prompt - Input prompt
   */
  async streamTokens(prompt: string): Promise<void> {
    for (const token of this.generateTokens(prompt)) {
      await this.sendToken(token)
      this.displayToken(token)
    }
  }
}
```

**Bad: Missing reassembly buffer**

```typescript
/**
 * Parallel chunks lacking reassembly buffer.
 * @description Chunks processed as they arrive.
 */
class BrokenChunkProcessor {
  /**
   * Process chunks as they arrive.
   * @description Lacks buffering for correct reassembly.
   * @param chunks - Data chunks to process
   */
  async processChunks(chunks: DataChunk[]): Promise<void> {
    await Promise.all(
      chunks.map(chunk =>
        fetch('/process', { method: 'POST', body: chunk.data }).then(() => {
          console.log(`Processed chunk ${chunk.sequence}`)
        })
      )
    )
  }
}

/**
 * Better: Buffer then reassemble.
 * @description Handles out-of-order arrivals correctly.
 */
class CorrectChunkProcessor {
  /** Map of sequence to chunk */
  private buffer = new Map<number, DataChunk>()

  /**
   * Buffer all chunks before processing.
   * @description Handles out-of-order arrivals.
   * @param chunks - Data chunks to process
   */
  async processChunks(chunks: DataChunk[]): Promise<void> {
    await Promise.all(
      chunks.map(async chunk => {
        const response = await fetch('/fetch', { method: 'POST', body: chunk.request })
        this.buffer.set(chunk.sequence, await response.json())
      })
    )
    const sortedSequences = Array.from(this.buffer.keys()).sort((a, b) => a - b)
    for (const seq of sortedSequences) {
      this.processInOrder(this.buffer.get(seq)!)
    }
  }
}
```

## Important Points

- **Sequence numbers are mandatory**, the receiver cannot determine order without explicit markers
- **Reassembly buffer** requires memory proportional to out-of-order window size
- **Sliding window protocols** manage buffer size and backpressure (TCP, QUIC)
- **Throughput gains** come from bypassing head-of-line blocking, not magic
- **HTTP/2 multiplexing** is a hybrid, multiple parallel streams with each stream internally sequential
- **Timeout handling** is critical, missing chunks block reassembly indefinitely without detection
- **Not suitable for** ordered streams where real-time processing matters (video, audio, tokens)

## Summary

- **Parallel**: chunks flow simultaneously over multiple streams, explicit ordering, complex implementation
- **Trade-off**: throughput and resilience vs complexity and memory overhead
- **Analogy**: multiple grocery checkout lanes with staging area for sequencing
- **Use for**: independent chunks (file parts, bulk transfers), throughput priority, resumable uploads
- **Avoid when**: order is critical and real-time processing is required

_Parallel streaming trades coordination overhead for speed. The reassembly buffer is the price you pay for bypassing the single-lane bottleneck._
