# Backup and Restore Guide

This document explains the backup system managed by the `~/bin/backup` script and how to restore files from the AWS S3 backup.

## How the Backup Works

The `~/bin/backup` script utilizes `rclone` to back up data to an AWS S3 bucket named `cmiranda-backup-beast`.

1.  **Synchronization:** The script runs `rclone sync` to synchronize the source directory with the `current` directory in the S3 bucket (`aws-s3:cmiranda-backup-beast/current`).
    *   **Important:** The current script configuration syncs the entire root filesystem (`/`). This is generally **not recommended** as it includes system files and can lead to issues during restoration, potentially overwriting critical system data on a new machine. It's advisable to change the source in the script to a more specific directory like `$HOME`.
2.  **Versioning:** Before synchronizing, `rclone` moves any files that are about to be updated or deleted in the `current` directory to a timestamped directory within the `archive` path (`aws-s3:cmiranda-backup-beast/archive/YYYYMMDD_HHMMSS`). This creates historical snapshots.
3.  **Filtering:** The backup process respects filters defined in `$HOME/.config/rclone/filter.txt`, allowing specific files or directories to be excluded.
4.  **Pruning:** A separate function (`prune`) removes older timestamped archives based on a retention policy, keeping only a specified number of recent backups.

## Backup Schedule

The backup process is automated via cron jobs defined in `~/.crontab`:

*   **Daily Backup:** A full backup (`backup backup --quiet`) runs every day at **00:00 (midnight)**.
*   **Daily Pruning:** Old backups are pruned (`backup prune --retention 14 --quiet`) every day at **04:00 AM**, keeping the **last 14** archived backups.

## Restoring Files

Restoring files requires `rclone` to be installed and configured correctly with the `aws-s3` remote pointing to the `cmiranda-backup-beast` bucket.

### Prerequisites

1.  **Install rclone:** Follow the official rclone installation guide: [https://rclone.org/install/](https://rclone.org/install/)
2.  **Configure rclone:** Run `rclone config` and set up a remote named `aws-s3` pointing to your `cmiranda-backup-beast` S3 bucket. Ensure you have the necessary AWS credentials. Your existing `$HOME/.config/rclone/rclone.conf` file should contain this configuration.

### Restoration Scenarios

**Important:** Due to the backup script currently backing up the entire root (`/`), **DO NOT** restore the entire backup directly to `/` on a new system. This will likely overwrite critical system files. It's highly recommended to restore specific directories (like your home directory) or restore the entire backup to a temporary location first.

1.  **Restore the Latest Version of Your Home Directory:**
    ```bash
    # Ensure the target directory exists, e.g., /home/cmiranda
    # Use --dry-run first to see what would be copied
    rclone sync aws-s3:cmiranda-backup-beast/current/home/cmiranda /home/cmiranda --progress --dry-run

    # If the dry run looks correct, remove --dry-run to perform the restore
    rclone sync aws-s3:cmiranda-backup-beast/current/home/cmiranda /home/cmiranda --progress
    ```
    *(Replace `cmiranda` with your actual username if it differs)*

2.  **Restore Specific Files/Directories from the Latest Version:**
    ```bash
    # Example: Restore the Documents directory
    rclone sync aws-s3:cmiranda-backup-beast/current/home/cmiranda/Documents /home/cmiranda/Documents --progress

    # Example: Restore a single configuration file
    rclone copyto aws-s3:cmiranda-backup-beast/current/home/cmiranda/.config/some_app/config.conf /home/cmiranda/.config/some_app/config.conf --progress
    ```

3.  **List Available Archived Backups:**
    To see which historical snapshots are available:
    ```bash
    rclone lsf aws-s3:cmiranda-backup-beast/archive/ --dirs-only
    ```
    This will output a list of timestamped directories (e.g., `20231027_103000/`).

4.  **Restore Your Home Directory from a Specific Archived Backup:**
    Find the timestamp of the backup you want using the command above.
    ```bash
    # Replace YYYYMMDD_HHMMSS with the desired timestamp
    TIMESTAMP="YYYYMMDD_HHMMSS"

    # Use --dry-run first
    rclone sync aws-s3:cmiranda-backup-beast/archive/${TIMESTAMP}/home/cmiranda /home/cmiranda --progress --dry-run

    # If correct, run without --dry-run
    rclone sync aws-s3:cmiranda-backup-beast/archive/${TIMESTAMP}/home/cmiranda /home/cmiranda --progress
    ```

5.  **Restore Specific Files/Directories from an Archived Backup:**
    ```bash
    # Replace YYYYMMDD_HHMMSS with the desired timestamp
    TIMESTAMP="YYYYMMDD_HHMMSS"

    # Example: Restore Documents from an old backup
    rclone sync aws-s3:cmiranda-backup-beast/archive/${TIMESTAMP}/home/cmiranda/Documents /home/cmiranda/Documents_restored --progress

    # Example: Restore a single file from an old backup
    rclone copyto aws-s3:cmiranda-backup-beast/archive/${TIMESTAMP}/path/to/your/file.txt /local/path/to/restore/file.txt --progress
    ```

Always use `--dry-run` first to verify the actions before making changes to your filesystem. Remember to replace placeholders like `cmiranda` and `YYYYMMDD_HHMMSS` with actual values.
