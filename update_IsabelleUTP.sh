#!/bin/bash

# Check if we are probably in the Isabelle directory
echo "Checking if Isabelle is available..."
if ! test -f bin/isabelle; then
  echo "Isabelle executable does not exist under bin/"
  echo "Is this script being run from the Isabelle directory?"
  exit 1;
fi

echo "Updating CyPhyAssure Git repositories..."
if ! test -d src/CyPhyAssure; then
  echo "CyPhyAssure repository does not exist under src/"
  exit 1;
fi

cd src/CyPhyAssure
git pull
git submodule update

echo "Building CyPhyAssure sessions..."
cd ../..

# Ensure the system heaps option is set, so that heap images are not built to home
sed -i --in-place "s/option system_heaps : bool = false/option system_heaps : bool = true/g" etc/options

bin/isabelle build -b ITree_VCG
bin/isabelle build -b ITree_Numeric_VCG
bin/isabelle build -b Z_Machines
bin/isabelle build -b Hybrid-Verification
bin/isabelle build -b Z_Toolkit
bin/isabelle build -b Circus_Toolkit
bin/isabelle build -b UTP2
bin/isabelle build -b UTP-Designs
bin/isabelle build -b UTP-Reactive

# Return systems heaps to false
sed -i --in-place "s/option system_heaps : bool = true/option system_heaps : bool = false/g" etc/options
