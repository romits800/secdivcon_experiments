#!/bin/bash
bench=$1
arch=$2
iter=$3

case $arch in
    mips)
          target=Mips; aflags=""; march=mipsel; mcpu=mips32;;
    thumb)
          target=Thumb; aflags="--targetoption cortex-m0"; march=thumb; mcpu=cortex-m0;;
    *)
          echo "Give architecture as the second argument"; exit 0;;
esac

UNI=${SECCON_PATH}/src/unison/build/uni

for i in {0..199}
do
    $UNI export --keepnops --target=$target $aflags ${bench}.alt.uni -o ${i}.${bench}.${iter}.unison.mir --solfile=${i}.${bench}.${iter}.out.json;

    llc ${i}.${bench}.${iter}.unison.mir -filetype=obj -march=$march -mcpu=$mcpu -disable-post-ra -disable-tail-duplicate -disable-branch-fold -disable-block-placement -start-after livedebugvars -o ${i}.${bench}.${iter}.o
    llc ${i}.${bench}.${iter}.unison.mir -march=$march -mcpu=$mcpu -disable-post-ra -disable-tail-duplicate -disable-branch-fold -disable-block-placement -start-after livedebugvars -o ${i}.${bench}.${iter}.s
done
