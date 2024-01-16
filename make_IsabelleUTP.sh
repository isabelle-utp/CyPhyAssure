#!/bin/bash

# Check if we are probably in the Isabelle directory
echo "Checking if Isabelle is available..."
if ! test -f bin/isabelle; then
  echo "Isabelle executable does not exist under bin/"
  echo "Is this script being run from the Isabelle directory?"
  exit 1;
fi

# Get the patch for Isabelle
if [ -x "$(command -v wget)" ]; then
  echo "Downloading CyPhyAssure patch with wget..."
  wget https://raw.githubusercontent.com/isabelle-utp/CyPhyAssure/main/Isabelle2023-CyPhyAssure.diff
elif [ -x "$(command -v curl)" ]; then
  echo "Downloading CyPhyAssure patch with curl..."
  curl -O https://raw.githubusercontent.com/isabelle-utp/CyPhyAssure/main/Isabelle2023-CyPhyAssure.diff
else
  echo "Cannot download patch, neither wget nor curl is available"
  exit 1
fi

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

