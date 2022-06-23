#!/bin/bash
bench=$1
arch=$2
case $arch in
    mips)
          target=Mips; aflags=""; march=mipsel; mcpu=mips32;;
    thumb)
          target=Thumb; aflags="--targetoption cortex-m0"; march=thumb; mcpu=cortex-m0;;
    *)
          echo "Give architecture as the second argument"; exit 0;;
esac


uni export --keepnops --target=$target $aflags ${bench}.sec.uni -o ${bench}.unison.mir --solfile=${bench}.out.json;

llc ${bench}.unison.mir -filetype=obj -march=$march -mcpu=$mcpu -disable-post-ra -disable-tail-duplicate -disable-branch-fold -disable-block-placement -start-after livedebugvars -o ${bench}.o
llc ${bench}.unison.mir -march=$march -mcpu=$mcpu -disable-post-ra -disable-tail-duplicate -disable-branch-fold -disable-block-placement -start-after livedebugvars -o ${bench}.s
