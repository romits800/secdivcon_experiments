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

UNI=${SECCON_PATH}/src/unison/build/uni

for i in {0..199}
do
    $UNI export --keepnops --target=$target $aflags ${bench}.alt.uni -o ${i}.${bench}.unison.mir --solfile=${i}.${bench}.out.json;

    llc ${i}.${bench}.unison.mir -filetype=obj -march=$march -mcpu=$mcpu -disable-post-ra -disable-tail-duplicate -disable-branch-fold -disable-block-placement -start-after livedebugvars -o ${i}.${bench}.o
    llc ${i}.${bench}.unison.mir -march=$march -mcpu=$mcpu -disable-post-ra -disable-tail-duplicate -disable-branch-fold -disable-block-placement -start-after livedebugvars -o ${i}.${bench}.s
done
#uni export --keepnops --target=$target $aflags ${bench}.sec.uni -o ${bench}.unison.mir --solfile=${bench}.gecode.out.json;

#llc ${bench}.unison.mir -filetype=obj -march=$march -mcpu=$mcpu -disable-post-ra -disable-tail-duplicate -disable-branch-fold -disable-block-placement -start-after livedebugvars -o ${bench}.o
#llc ${bench}.unison.mir -march=$march -mcpu=$mcpu -disable-post-ra -disable-tail-duplicate -disable-branch-fold -disable-block-placement -start-after livedebugvars -o ${bench}.s
