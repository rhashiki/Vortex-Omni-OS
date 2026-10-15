import pathlib
import unittest

ROOT = pathlib.Path(__file__).resolve().parents[1]

class BuildContract(unittest.TestCase):
    def test_build_requires_explicit_base(self):
        s = (ROOT / "build/scripts/build-image.sh").read_text()
        self.assertIn('BASE_IMAGE="${BASE_IMAGE:-}"', s)
        self.assertIn('validate-base.py "$BASE_IMAGE"', s)
    def test_no_github_actions_workflows(self):
        workflows = ROOT / ".github/workflows"
        self.assertFalse(workflows.exists() and any(workflows.iterdir()))
    def test_oci_containerfile_exists(self):
        s = (ROOT / "build/Containerfile").read_text()
        self.assertIn("FROM ${BASE_IMAGE}", s)
    def test_policy_not_approved(self):
        s = (ROOT / "security/DEPENDENCY_AUDIT.md").read_text()
        self.assertIn("NOT APPROVED", s)

if __name__ == "__main__":
    unittest.main()
