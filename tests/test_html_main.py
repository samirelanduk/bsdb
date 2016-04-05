import unittest
import time
from base_html import RootHtmlTest

class HtmlContentTest(RootHtmlTest):

    def test_home_page(self):

        self.go_to_page("/", self.app_name, self.app_name)


if __name__ == "__main__":
    unittest.main(warnings="ignore")
