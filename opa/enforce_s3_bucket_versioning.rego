package terraform

import input as tfplan



s3_buckets[r] {
    r := tfplan.resource_changes[_]
    r.type == "aws_s3_bucket"
}


# Rule to require
deny[reason] {
    r := s3_buckets[_]
    r.change.after.versioning[0].enabled == false
    reason := sprintf(
        "%s: requires versioning enabled",
        [r.change.after.bucket]
    )
}
#### TO-DO: Enable MFA-Delete
# deny[reason] {
#     r := s3_buckets[_]
#     r.change.after.versioning[0].mfa_delete == false
#     reason := sprintf(
#         "%s: requires versioning mfa_delete enabled",
#         [r.change.after.bucket]
#     )
# }
