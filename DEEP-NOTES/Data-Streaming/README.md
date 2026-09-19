# Data Streaming

_Chunk streaming patterns comparing sequential versus parallel and throughput versus ordering._

## Contents

| File                                         | Topic                | One-line                                                                     |
| -------------------------------------------- | -------------------- | ---------------------------------------------------------------------------- |
| [sequential-chunk.md](./sequential-chunk.md) | Sequential Streaming | One chunk at a time in order, natural ordering but head-of-line blocking     |
| [parallel-chunk.md](./parallel-chunk.md)     | Parallel Streaming   | Multiple chunks simultaneously, needs sequence numbers and reassembly buffer |
