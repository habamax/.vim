################################################################################
                                    VIM-DIR
################################################################################
:author: Maxim Kim <habamax@gmail.com>
:date:   |date|

.. |date| date::
.. role:: kbd

WIP. File manager for Vim.

Features
========

- ✓ (2022-07-10) Navigate file system, show contents like ``ls``.

- ✓ (2022-07-10) Open files/directories in splits/tabs.

- Sorting.

- Filtering.

- Open files with external applications (``xdg-open``, ``open``, ``start``).

- History of directories.

- Bookmarks.

- Basic file operations support:

  - ✓ (2022-07-10) Create a file (use ``:e filename`` from ``Dir`` buffer)
  - Create a directory
  - Delete a file or a directory (with selection support)
  - Copy a file or a directory (with selection support)
  - Move a file or a directory (with selection support)
  - chmod? chown?

- Explore mass rename ala ``qmv``/``vidir``

- Explore networking (mc like shell or sftp links to machines).


Non Features
============

- No treeview, no sidepanel.
