#!/bin/bash

files=`find . -type f -name "*.h"`
for file in files
do
#sed -i 's/keymaster0/keymaster2/g'
	sed -i '/^__BEGIN_DECLS/c\#if defined(__cplusplus)\nextern "C" {\n#endif' $file
	sed -i '/^__BEGIN_DECLS/c\#if defined(__cplusplus)\n}\n#endif' $file
done
