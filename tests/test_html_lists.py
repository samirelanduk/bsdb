import unittest
import time
from base_html import RootHtmlTest

class ListHtmlTest(RootHtmlTest):

    def check_list_page_structure(self, categories, headings, column_checkers):
        # Get the list container
        list_container = self.browser.find_element_by_id("list_container")

        # Check list categories
        list_categories = list_container.find_element_by_id("list_categories")
        for category in categories:
            self.assertIn(category, list_categories.text)
        self.assertEqual(len(list_categories), len(categories))

        # Check description
        self.assertEqual(
         len(list_container.find_elements_by_tag_name("p")),
         1
        )
        self.assertGreater(
         len(list_container.find_element_by_tag_name("p").text),
         20
        )

        # Check table head
        table = list_container.find_elements_by_tag_name("table")[-1]
        heading_cells = table.find_elements_by_tag_name("th")
        for index, heading in enumerate(heading_cells):
            self.assertEqual(heading.text, headings[index])
        self.assertEqual(len(headings), len(heading_cells))

        # Check table rows
        rows = table.find_elements_by_tag_name("tr")
        self.assertGreater(len(rows), 100)
        for row in rows[:20] + rows[-20:]:
            cells = row.find_elements_by_tag_name("td")
            for cell_index, cell in enumerate(cells):
                self.assertTrue(column_checkers[cell_index](cell.text))
            if cells: a = cells[0].find_element_by_tag_name("a")


    def check_box_table(self, box, box_title, table_fields, value_checkers):
        self.assertEqual(
         box.find_element_by_class_name("box_title").text,
         box_title
        )
        table = box.find_element_by_tag_name("table")
        for row_index, row in enumerate(table.find_elements_by_tag_name("tr")):
            self.assertEqual(
             row.find_elements_by_tag_name("td")[0].text,
             table_fields[row_index]
            )
            self.assertTrue(
             value_checkers[row_index](row.find_elements_by_tag_name("td")[1].text)
            )


    def test_ligand_list_page(self):
        # Go to the ligand list page
        self.go_to_page("/ligands", "Ligands", "All Ligands")

        # Check structure is correct
        list_categories = [
         "All", "Approved", "Synthetic organic", "Metabolite", "Natural product",
         "Endogenous peptide", "Other peptide", "Inorganic", "Antibody"
        ]
        list_headings = [
         "Name", "ID", "Approved", "Type", "Mass", "Synonyms"
        ]
        column_checkers = [
         len,
         lambda k: k == "0" or int(k),
         lambda k: k in ("Yes", "No"),
         lambda k: k in list_categories,
         float,
         lambda k: True
        ]
        self.check_list_page_structure(list_categories, list_headings, column_checkers)


    def test_ligand_detail_page(self):
        # Go to ligand 121 page
        self.go_to_page("/ligands/detail.jsp?id=121", "dihydroergotamine", "dihydroergotamine")

        # Get container
        container = self.browser.find_element_by_id("detail_container")

        # Check title div has h1, GtoP link, and other links
        title_div = container.find_elements_by_tag_name("div")[0]
        h1 = title_div.find_element_by_tag_name("h1")
        gtop_link = title_div.find_element_by_id("gtop_link")
        self.assertEqual(
         gtop_link.text,
         "Guide to PHARMACOLOGY ID: 121"
        )
        self.assertEqual(
         gtop_link.find_element_by_tag_name("a").get_attribute("href"),
         "http://www.guidetopharmacology.org/GRAC/LigandDisplayForward?ligandId=121"
        )
        other_links = title_div.find_elements_by_class_name("db_link")
        for link in other_links:
            self.assertRegex(link.text, r"^[.+] - [.+]$")

        # Check structure image
        structure_box = container.find_elements_by_class_name("box")[0]
        self.assertEqual(
         structure_box.find_element_by_class_name("box_title").text,
         "Structure"
        )
        img = structure_box.find_element_by_tag_name("img")
        self.assertEqual(
         img.get_attribute("src"),
         "http://www.guidetopharmacology.org/CHEMSTRUCT/iuphar/121.gif"
        )

        # Check molecular details
        self.check_box_table(
         box=container.find_elements_by_class_name("box")[1],
         box_title="Molecular Details",
         table_fields=[
          "Molecular mass (Da)",
          "Hydrogen bond acceptors",
          "Hydrogen bond donors",
          "Polar surface area (A2)",
          "Lipinski rules broken"
         ],
         value_checkers = [
          float,
          lambda k: k == "0" or int(k),
          lambda k: k == "0" or int(k),
          float,
          lambda k: k == "0" or int(k),
         ]
        )

        # Check other details
        self.check_box_table(
         box=container.find_elements_by_class_name("box")[2],
         box_title="Other Details",
         table_fields=[
          "Ligand type",
          "Radiolabelled",
          "Approved",
          "Approval Source",
         ],
         value_checkers = [
          len,
          lambda k: k in ("Yes", "No"),
          lambda k: k in ("Yes", "No"),
          lambda k: True,
         ]
        )

        # Check responsive elements
        sequence_box = container.find_elements_by_class_name("box")[3]
        self.assertEqual(
         sequence_box.find_element_by_class_name("box_title").text,
         "Responsive Sequences"
        )
        sequences = sequence_box.find_elements_by_class_name("sequence_link")
        for sequence in sequences:
            self.assertIn(
             "receptor",
             sequence.text
            )
            self.assertIn(
             "residues)",
             sequence.text
            )


    def test_sequence_list_page(self):
        # Go to the ligand list page
        self.go_to_page(
         "/sequences", "Sequences", "All Drug Responsive Sequences"
        )

        # Check structure is correct
        list_categories = [
         "All", "Approved drugs", "Short", "Long", "Hydrophobic", "Hydrophilic",
         "Small Proportional Length"
        ]
        list_headings = [
         "ID", "Target", "Species", "Ligand", "Length", "Proportional Length"
        ]
        column_checkers = [
         int,
         len,
         len,
         len,
         int,
         lambda k: k.endswith("%")
        ]
        self.check_list_page_structure(list_categories, list_headings, column_checkers)


    def test_sequence_detail_page(self):
        # Go to sequence 143 page
        self.go_to_page("/sequences/detail.jsp?id=143", "Human 5-HT1B receptor", "Human 5-HT1B receptor")

        # Get container
        container = self.browser.find_element_by_id("detail_container")

        # Check title div has h1 and ligand link
        title_div = container.find_elements_by_tag_name("div")[0]
        h1 = title_div.find_element_by_tag_name("h1")
        ligand_link = title_div.find_element_by_id("ligand_link")
        self.assertEqual(
         ligand_link.text,
         "with dihydroergotamine"
        )


        # Check structure image
        structure_box = container.find_elements_by_class_name("box")[0]
        self.assertEqual(
         structure_box.find_element_by_class_name("box_title").text,
         "Structure"
        )
        img = structure_box.find_element_by_tag_name("img")
        self.assertEqual(
         img.get_attribute("src"),
         self.root_url + "/static/images/pymol/143.png"
        )

        # Check sequence
        sequence_box = container.find_elements_by_class_name("box")[1]
        self.assertEqual(
         sequence_box.find_element_by_class_name("box_title").text,
         "Sequence"
        )
        sequence = sequence_box.find_element_by_id("sequence").text
        self.assertGreater(
         len(sequence),
         5
        )
        for char in sequence:
            self.assertIn(
             char.lower(),
             "galmfwkqespvicyhrndt"
            )

        # Check pdb details
        self.check_box_table(
         box=container.find_elements_by_class_name("box")[2],
         box_title="PDB Details",
         table_fields=[
          "PDB code",
          "HET name",
          "HET ID",
          "Chain"
         ],
         value_checkers = [
          lambda k: len(k) == 4,
          lambda k: len(k) == 3,
          int,
          lambda k: len(k) == 1 and k.isalpha()
         ]
        )

        # Check other details
        self.check_box_table(
         box=container.find_elements_by_class_name("box")[3],
         box_title="Other Details",
         table_fields=[
          "Affinity",
          "Affinity type",
          "Sequence length",
          "Proportion of original chain length",
          "Internal contacts",
          "External contacts",
          "Contact ratio"
         ],
         value_checkers = [
          lambda k: True,
          lambda k: True,
          int,
          lambda k: k.endswith("%"),
          int,
          int,
          lambda k: k.endswith("%")
         ]
        )

        # Check svg amination (a bit)
        matrix_box = container.find_elements_by_class_name("box")[4]
        self.assertEqual(
         matrix_box.find_element_by_class_name("box_title").text,
         "Residue Distances"
        )



class ListRedirectTest(RootHtmlTest):

    def test_sequence_redirects(self):
        for location in [
         "/sequences/detail.jsp",
         "/sequences/detail.jsp?id=0",
         "/sequences/detail.jsp?id=xxx",
        ]:
            self.go_to_page(location, "Sequences", "All Drug Responsive Sequences")


    def test_ligand_redirects(self):
        for location in [
         "/ligands/detail.jsp",
         "/ligands/detail.jsp?id=0",
         "/ligands/detail.jsp?id=xxx",
        ]:
            self.go_to_page(location, "Ligands", "All Ligands")


if __name__ == "__main__":
    unittest.main(warnings="ignore")
