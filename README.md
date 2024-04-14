![CI run](https://github.com/dimikot/run-in-separate-pgrp/actions/workflows/ci.yml/badge.svg?branch=main)

# run-in-separate-pgrp: launch a console command in a newly created foreground process group

This is a wrapper tool which launches an arbitrary command in a newly created
foreground process group. This allows to limit the scope of Ctrl-C SIGINT
propagation to only the hierarchy of that new process group (terminals propagate
SIGINT to ALL processes of a foreground process group when Ctrl-C is pressed,
which may kill some intermediate processes like yarn).

As an example, the tool can be used to let interactive `psql` run in a `yarn`
script (`yarn` dies on SIGINT, which effectively closes STDIN for `psql`).

As opposed to most of other command-launching tools (`concurrently`, `yarn`
etc.), the `run-in-separate-pgrp` properly propagates the wrapped command's
termination signals back to its exit code. E.g. if the wrapped command was
killed with SIGTERM, the wrapper will also show itself terminated with SIGTERM.

See details here:
- https://www.postgresql.org/message-id/flat/271520.1713052173%40sss.pgh.pa.us#6ebc31cdb0365b0de9e0a2e7e5cb2268
- https://www.cons.org/cracauer/sigint.html

## Usage

You can download the tool file `run-in-separate-pgrp` and put it anywhere you
want (it's a stand-alone Perl script with no dependencies):

```
wget https://raw.githubusercontent.com/dimikot/run-in-separate-pgrp/main/run-in-separate-pgrp
chmod +x run-in-separate-pgrp
```

Alternatively, you can install it as a Node module to be available in your PATH:

```
npm install run-in-separate-pgrp
yarn add run-in-separate-pgrp
pnpm install run-in-separate-pgrp
```
