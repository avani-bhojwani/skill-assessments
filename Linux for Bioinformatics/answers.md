# Answers to questions from "Linux for Bioinformatics"

Q1. What is your home directory?

A: /home/ubuntu

Q2. What is the output of this command?

A: `hello_world.txt`

Q3: What is the output of each ls command?

A: For `my_folder`, there's no output. For `my_folder2`, the output is `hello_world.txt`.

Q4: What is the output of each?

A: For `my_folder` and `my_folder2`, there's no output. For `my_folder3`, the output is `hello_world.txt`.

Q5: What editor did you use and what was the command to save your file changes?

A: I used nano and the command to save my file changes was `ctrl + o`.

Q6: What is the error?

A: `PuTTY Fatal Error: No supported authentication methods available (server sent: publickey). Server refused our key.`

Q7: What was the solution?

A: I generated a new key pair on my local machine and added its public key to a file within `sudouser`'s home directory at `~/.ssh/authorized_keys`. I then used this key pair to log into the remote server.

Q8: What does the `sudo docker run` part of the command do? and what does the `salmon swim` part of the command do?

A: `sudo` is needed to run the docker command as a non-root user. `docker run` runs a command in a new container. `salmon swim` is used to "perform a super-secret operation" where the word salmon is printed out in the terminal.

Q9: What is the output of this command?

A: `serveruser is not in the sudoers file. This incident will be reported.`

Q10: What is the output of `flask --version`?

A: 
```
Python 2.7.15
Flask 1.1.4
Werkzeug 1.0.1
```

Q11: What is the output of `mamba --version`?

A: `conda 22.9.0`

Q12: What is the output of `which python`?

A: `/home/serveruser/mambaforge/envs/py27/bin/python`

Q13: What is the output of `which python` now?

A: `/home/serveruser/mambaforge/bin/python`

Q14: What is the output of `salmon -h`?

A:
```
salmon v1.4.0

Usage:  salmon -h|--help or
        salmon -v|--version or
        salmon -c|--cite or
        salmon [--no-version-check] <COMMAND> [-h | options]

Commands:
     index      : create a salmon index
     quant      : quantify a sample
     alevin     : single cell analysis
     swim       : perform super-secret operation
     quantmerge : merge multiple quantifications into a single file
```

Q15. What does the `-o athal.fa.gz` part of the command do? 

A: It writes output to a file called `athal.fa.gz`.

Q16: What is a `.gz` file?

A: It's a GZip compressed file.

Q17: What does the `zcat` command do?

A: It uncompresses a GZip compressed file and prints the output.

Q18: What does the `head` command do?

A: It prints the first few lines of the file. The number of lines printed is specified with `-n`.

Q19: What does the number `100` signify in the command?

A: It is the number of lines that will be printed.

Q20: What is `|` doing?

A: It is piping the output of the command on the left to the command on the right. i.e. It's taking the uncompressed output from the `.gz` file and giving it to the `head` command.

Q21: What is a `.fa` file? What is this file format used for?

A: It is a FASTA file, which is a file type used to store data about DNA sequences.

Q22: What format are the downloaded sequencing reads in?

A: The downloaded file isa `. sra` file. This is the SRA Normalised Format which contains full, per-base quality scores.

Q23. What is the total size of the disk?

A: 7.6 GB

Q24. How much space is remaining on the disk?

A: 2.3 GB

Q25: What went wrong?

A: There was not enough storage space on the disk to complete the command.

Q26: What was your solution?

A: I compressed the output by adding `-- gzip` to the command.