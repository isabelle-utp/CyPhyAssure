#!/bin/bash

# Get the patch for Isabelle
wget https://raw.githubusercontent.com/isabelle-utp/CyPhyAssure/main/Isabelle2023-CyPhyAssure.diff

# Patch Isabelle
patch -p1 < Isabelle2023-CyPhyAssure.diff

# Ensure the system heaps option is set, so that heap images are not built to home
sed -i --in-place "s/option system_heaps : bool = false/option system_heaps : bool = true/g" etc/options

# Get the CyPhyAssure repository
cd src
git clone https://github.com/isabelle-utp/CyPhyAssure.git
cd CyPhyAssure
git submodule update --init --recursive
cd ../..
echo "src/CyPhyAssure" >> ROOTS

# Build main sessions
bin/isabelle build -b ITree_VCG
bin/isabelle build -b Z_Machines
bin/isabelle build -b Hybrid-Verification
bin/isabelle build -b Z_Toolkit
bin/isabelle build -b UTP

