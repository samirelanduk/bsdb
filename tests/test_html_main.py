import unittest
import time
from base_html import RootHtmlTest

class HtmlContentTest(RootHtmlTest):

    def check_links_back_to_about_page(self):
        main_links = [
         a.get_attribute("href") for a in
         self.browser.find_element_by_tag_name("main").find_elements_by_tag_name("a")
        ]
        self.assertIn(self.root_url + "/about", main_links)


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


    def test_about_database_page(self):
        # Go to the database page
        self.go_to_page(
         "/about/database", "About the database", "About the database"
        )

        # Check link back to about page
        self.check_links_back_to_about_page()

        # Is there a bunch of paragraphs?
        paragraphs = self.browser.find_elements_by_tag_name("p")
        self.assertGreaterEqual(len(paragraphs), 5)

        # Are there sub-headings?
        subheadings = self.browser.find_elements_by_tag_name("h2")
        self.assertGreaterEqual(len(subheadings), 1)


    def test_help_page(self):
        # Go to the database page
        self.go_to_page("/about/help", "Help", "Help")

        # Check link back to about page
        self.check_links_back_to_about_page()

        # Check sections
        boxes = self.browser.find_elements_by_class_name("box")
        box_titles = [box.find_element_by_class_name("box_title") for box in boxes]
        self.assertIn("searching", box_titles[0].text.lower())
        self.assertIn("ligands", box_titles[1].text.lower())
        self.assertIn("sequences", box_titles[2].text.lower())
        self.assertIn("general", box_titles[3].text.lower())

        # Check subsections
        subsection_titles = [
         ["search by ligand", "search by sequence", "search everything"],
         ["ligand list", "ligand page"],
         ["sequence list", "sequence page"],
         ["contacting us"]
        ]
        for box_index, box in enumerate(boxes):
            subsections = box.find_elements_by_class_name("help_subsection")
            for subsection_index, subsection in enumerate(subsections):
                self.assertEqual(
                 subsection_titles[box_index][subsection_index],
                 subsection.find_element_by_tag_name("h2").text.lower()
                )
                paragraphs = subsection.find_elements_by_tag_name("p")
                self.assertGreaterEqual(len(paragraphs), 2)


    def test_stats_page(self):
        # Go to the database page
        self.go_to_page(
         "/about/data", "Data and Statistics", "Data and Statistics"
         )

        # Check link back to about page
        self.check_links_back_to_about_page()

        #Check ligand stats
        ligand_div = self.browser.find_element_by_id("ligand_stats")
        boxes = ligand_div.find_elements_by_class_name("box")
        ligand_headings = ["by type", "by mass", "approval status"]
        for index, box in enumerate(boxes):
            box_title = box.find_element_by_class_name("box_title")
            self.assertIn(ligand_headings[index], box_title.text.lower())
            explanation = box.find_element_by_class_name("explanation")
            graphic = box.find_element_by_tag_name("svg")

        #Check sequence stats
        sequence_div = self.browser.find_element_by_id("sequence_stats")
        boxes = sequence_div.find_elements_by_class_name("box")
        sequence_headings = ["by target type", "by species", "contiguity by"]
        for index, box in enumerate(boxes):
            box_title = box.find_element_by_class_name("box_title")
            self.assertIn(sequence_headings[index], box_title.text.lower())
            explanation = box.find_element_by_class_name("explanation")
            graphic = box.find_element_by_tag_name("svg")


    def test_sponsors_page(self):
        # Go to the database page
        self.go_to_page("/about/sponsors", "Sponsors", "Sponsors")

        # Check link back to about page
        self.check_links_back_to_about_page()

        # Are all the sponsors there?
        main_text = self.browser.find_element_by_tag_name("main")
        for sponsor_name in self.sponsor_names:
            self.assertIn(sponsor_name, main_text.text)

        # Are all the sponsors linked to?
        main_links = [
         a.get_attribute("href") for a in main_text.find_elements_by_tag_name("a")
        ]
        for sponsor_url in self.sponsor_urls:
            self.assertIn(sponsor_url, main_links)


    def test_citing_page(self):
        # Go to the database page
        self.go_to_page("/citing", "Citing", "how to cite")


    def test_privacy_page(self):
        # Go to the database page
        self.go_to_page("/privacy", "privacy", "Privacy Policy")



if __name__ == "__main__":
    unittest.main(warnings="ignore")
