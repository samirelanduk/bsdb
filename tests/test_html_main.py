import unittest
import time
from base_html import RootHtmlTest

class HtmlContentTest(RootHtmlTest):

    def test_home_page(self):
        self.go_to_page("/", self.app_name, self.app_name)


    def test_about_page(self):
        # Go to the about page
        self.go_to_page("/about", "About", "About")

        # Get the boxes
        boxes = self.browser.find_elements_by_class_name("box")

        # Verify the boxes have the correct title and link
        self.assertEqual(
         boxes[0].find_element_by_class_name("box_title").text.lower(),
         "this database"
        )
        self.assertEqual(
         boxes[1].find_element_by_class_name("box_title").text.lower(),
         "help"
        )
        self.assertEqual(
         boxes[2].find_element_by_class_name("box_title").text.lower(),
         "data and statistics"
        )
        self.assertEqual(
         boxes[3].find_element_by_class_name("box_title").text.lower(),
         "sponsors"
        )
        self.assertEqual(
         boxes[0].find_elements_by_tag_name("a")[-1].get_attribute("href"),
         self.root_url + "/about/database"
        )
        self.assertEqual(
         boxes[1].find_elements_by_tag_name("a")[-1].get_attribute("href"),
         self.root_url + "/about/help"
        )
        self.assertEqual(
         boxes[2].find_elements_by_tag_name("a")[-1].get_attribute("href"),
         self.root_url + "/about/data"
        )
        self.assertEqual(
         boxes[3].find_elements_by_tag_name("a")[-1].get_attribute("href"),
         self.root_url + "/about/sponsors"
        )

        # Verify general box properties
        for box in boxes:
            # Each box has a body
            body = box.find_element_by_class_name("box_body")

            # Each box has at least two paragraphs
            paragraphs = box.find_elements_by_tag_name("p")
            self.assertGreaterEqual(len(paragraphs), 2)

            # Each box has a 'Read More...'
            read_more = body.find_element_by_class_name("box_body_readmore")



if __name__ == "__main__":
    unittest.main(warnings="ignore")
