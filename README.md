# CyPhyAssure
This is a meta-repository for all the CyPhyAssure tools for Isabelle, including Isabelle/UTP. It includes submodules for most of the repositories, and a `ROOTS` file, which imports all the Isabelle sessions. It also includes a slightly adapted version of the AFP, to provide all the dependencies.

To use this repository, you'll need Isabelle 2021-1 from the [Isabelle website](https://isabelle.in.tum.de/). Next, clone the CyPhyAssure repository and make sure all the submodules are checked out. Then, start Isabelle 2021-1 with the command `isabelle jedit -d path/to/CyPhyAssure -l Session_Name`. Here, `Session_Name` could be something like `UTP`, `Z_Toolkit`, or `Z_Machines`. Isabelle should then proceed to build the requested session.
