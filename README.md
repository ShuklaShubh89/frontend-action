# Frontend GitHub Actions 🔄

This simple action uses the [vanilla AWS CLI](https://docs.aws.amazon.com/cli/index.html) to sync a directory with a remote S3 bucket and invalidate the cloudfront cache of commmon files.


## Usage

### `workflow.yml` Example

Place in a `.yml` file such as this one in your `.github/workflows` folder. [Refer to the documentation on workflow YAML syntax here.](https://help.github.com/en/articles/workflow-syntax-for-github-actions)


#### The following example includes optimal defaults for a public static website:

- `--acl public-read` makes your files publicly readable (make sure your [bucket settings are also set to public](https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteAccessPermissionsReqd.html)).
- `--follow-symlinks` won't hurt and fixes some weird symbolic link problems that may come up.
- Most importantly, `--delete` **permanently deletes** files in the S3 bucket that are **not** present in the latest version of your repository/build.
- **Optional tip:** If you're uploading the root of your repository, adding `--exclude '.git/*'` prevents your `.git` folder from syncing, which would expose your source code history if your project is closed-source. (To exclude more than one pattern, you must have one `--exclude` flag per exclusion. The single quotes are also important!)

```yaml

name: Upload Website and invalidate CF cache

on:
  push:
    branches:
    - master

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - uses: ShuklaShubh89/frontend-action@master
      with:
        args: --follow-symlinks --delete
      env:
        AWS_S3_BUCKET: ${{ secrets.AWS_S3_BUCKET }}
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        AWS_REGION: 'us-west-1'   # optional: defaults to us-east-1
        SOURCE_DIR: 'public'      # optional: defaults to entire repository