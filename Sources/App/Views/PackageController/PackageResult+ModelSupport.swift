// Copyright Dave Verwer, Sven A. Schmidt, and other contributors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation


extension PackageController.PackageResult {

    func authors() -> AuthorMetadata? {
        if let spiManifest = defaultBranchVersion.spiManifest,
           let metadata = spiManifest.metadata,
           let authors = metadata.authors {
            return AuthorMetadata.fromSPIManifest(authors)
        } else if let authors = repository.authors {
            return AuthorMetadata.fromGitRepository(authors)
        } else {
            return nil
        }
    }

    func activity() -> PackageShow.Model.Activity? {
        guard repository.lastPullRequestClosedAt != nil else { return nil }

        let openIssues = Link(label: repository.openIssues.labeled("open issue"),
                              url: package.url.droppingGitExtension + "/issues")
        let openPRs = Link(label: repository.openPullRequests.labeled("open pull request"),
                           url: package.url.droppingGitExtension + "/pulls")
        let lastIssueClosed = repository.lastIssueClosedAt.map { "\(date: $0, relativeTo: Current.date())" }
        let lastPRClosed = repository.lastPullRequestClosedAt.map { "\(date: $0, relativeTo: Current.date())" }
        return .init(openIssuesCount: repository.openIssues,
                     openIssues: openIssues,
                     openPullRequests: openPRs,
                     lastIssueClosedAt: lastIssueClosed,
                     lastPullRequestClosedAt: lastPRClosed)
    }

}
