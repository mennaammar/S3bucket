# Check S3 bucket is not public

package terraform

import input as tfplan

deny[reason] {
	r = tfplan.resource_changes[_]
	r.mode == "managed"
	r.type == "aws_s3_bucket"
	count(r.change.after.server_side_encryption_configuration[0].rule) == 0

	reason := sprintf("%-40s :: S3 buckets versioning must be enabled", 
	                    [r.change.after.bucket])
}