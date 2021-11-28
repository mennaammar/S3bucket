package terraform

import input as tfplan



s3_buckets[r] {
    r := tfplan.resource_changes[_]
    r.type == "aws_s3_bucket"
}


# Rule to require
deny[reason] {
    r := s3_buckets[_]
    count(r.change.after.logging) == 0
    reason := sprintf(
        "%s: requires logging enabled",
        [r.change.after.bucket]
    )
}

