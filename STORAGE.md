# POCO X5 Pro storage map

Read-only UFS survey from the POCO X5 Pro reported a valid GPT on the 256 GB UFS unit. The phone already has a dedicated `darwin` partition at the end of storage:

| Partition | LBA range | Approximate size |
| --- | ---: | ---: |
| `userdata` | 2,967,552–56,614,399 | 204 GiB |
| `darwin` | 56,614,400–61,857,786 | 20 GiB |

The current iOS 27 system APFS image is about 4.37 GB, so the existing `darwin` partition can hold the system and persistent Darwin data. A 64 GiB `darwin` partition would start near LBA 45,080,571 and take about 44 GiB from the end of `userdata`. Rewriting only the GPT would truncate Android data; that is not a safe resize. A larger allocation needs an offline filesystem shrink and backup before the partition table changes.

No GPT or phone partition has been written during this work.
