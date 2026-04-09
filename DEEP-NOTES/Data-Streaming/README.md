# Data Streaming Deep Notes

_Streaming patterns: sequential vs parallel, chunking strategies, and when to pick which approach._

## Contents

| File                                         | Topic                | One-line                                                                     |
| -------------------------------------------- | -------------------- | ---------------------------------------------------------------------------- |
| [sequential-chunk.md](./sequential-chunk.md) | Sequential Streaming | One chunk at a time in order, natural ordering but head-of-line blocking     |
| [parallel-chunk.md](./parallel-chunk.md)     | Parallel Streaming   | Multiple chunks simultaneously, needs sequence numbers and reassembly buffer |

---

_To add a new streaming topic: create a markdown file following the structure, then add it to the table above._
