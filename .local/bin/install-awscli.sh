install-awscli() {
 local pypkgs

 pypkgs='pip awscli boto boto3'

 pip install --upgrade $pypkgs
}
