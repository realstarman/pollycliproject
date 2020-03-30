# Description
A command line script for MacOS that calls [Amazon Polly](https://aws.amazon.com/polly/) and plays the resulting mp3 file.
By default, the mp3 file is deleted after playback.

# Purpose
The script enables the user to try out polly functionality and listen to the result without knowing a lot about the parameters.
The user can learn about advanced parameters gradually

# Installation
*Requires properly setup AWS CLI. If you do not have this, first follow these [instructions](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html).*
1. Download polly.sh and put it into your path
2. cd to the location of the script and make it executable (`chmod +x ./polly.sh`)
3. *Optional:* Create an allias „polly“ for „polly.sh“ - e.g. in .bash_profile, add a line
`alias polly='polly.sh'`
4. Create or appoint a directory for you temp speech file and choose a name. Then set the variable „pollyfile“ in `polly.sh`
5. Turn up your volume, run `polly.sh „Hello World“` and have fun!

# Usage
Run `polly.sh` to read the command line options.

# License
MIT License

Copyright (c) 2020 Siegi Polysius

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

