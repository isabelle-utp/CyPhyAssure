#!/bin/bash

sed -i --in-place "s/option system_heaps : bool = false/option system_heaps : bool = true/g" etc/options

echo "Updating CyPhyAssure Git repositories..."

cd src/CyPhyAssure
git pull
git submodule update

echo "Building CyPhyAssure sessions..."
cd ../..

bin/isabelle build -b ITree_VCG
bin/isabelle build -b Z_Machines
bin/isabelle build -b Hybrid-Verification
bin/isabelle build -b Z_Toolkit
bin/isabelle build -b UTP
