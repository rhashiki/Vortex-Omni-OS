import importlib.util
import pathlib
import unittest

p = pathlib.Path(__file__).resolve().parents[1] / "build/scripts/validate-base.py"
spec = importlib.util.spec_from_file_location("validate_base", p)
mod = importlib.util.module_from_spec(spec)
spec.loader.exec_module(mod)

class TestBase(unittest.TestCase):
    def test_accepts_digest(self):
        mod.validate("ghcr.io/ublue-os/kinoite-main@sha256:" + "a" * 64)
    def test_rejects_tag(self):
        with self.assertRaises(ValueError):
            mod.validate("ghcr.io/ublue-os/kinoite-main:stable")
    def test_rejects_other_registry(self):
        with self.assertRaises(ValueError):
            mod.validate("example.com/other@sha256:" + "a" * 64)
    def test_rejects_short_digest(self):
        with self.assertRaises(ValueError):
            mod.validate("ghcr.io/ublue-os/kinoite-main@sha256:1234")

if __name__ == "__main__":
    unittest.main()
