#!/bin/sh

git clone https://github.com/jtplaarj/IceCream-Bash.git ./bash_modules/IceCream-Bash && \
git clone https://github.com/yaacov/argparse-sh.git ./bash_modules/argparse-sh && \

echo "
#!/bin/sh

source ./bash_modules/IceCream-Bash/src/ic.sh
source ./bash_modules/argparse-sh/argparse.sh
" > ./bash_modules/bash_modules.sh && \

chmod u+x ./bash_modules/bash_modules.sh