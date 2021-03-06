/**
 * Copyright 2011 Joao Miguel Pereira
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
package eu.jpereira.trainings.designpatterns.creational.builder;

import static org.junit.Assert.assertEquals;

import eu.jpereira.trainings.designpatterns.creational.builder.html.HMTLReportBodyBuilder;
import eu.jpereira.trainings.designpatterns.creational.builder.json.JSONReportBodyBuilder;
import eu.jpereira.trainings.designpatterns.creational.builder.model.*;
import eu.jpereira.trainings.designpatterns.creational.builder.xml.XMLReportBodyBuilder;
import org.junit.Test;

/**
 * @author jpereira
 * 
 */
public class ReportAssemblerTest {

	@Test
	public void testAssembleJSONReportBody() {

		ReportBodyBuilder bodyBuilder = new JSONReportBodyBuilder();
		ReportAssembler reportAssembler = new ReportAssembler();
		Report report;
		reportAssembler.setSaleEntry(createDummySaleEntry());
		report= reportAssembler.getReport(bodyBuilder);
		String expected = "sale:{customer:{name:\"Bob\",phone:\"1232232\"},items:[{name:\"Computer\",quantity:2,price:99.9},{name:\"Printer\",quantity:1,price:79.8}]}";
		assertEquals(expected, report.getAsString());
	}

	@Test
	public void testAssembleXMLReportBody() {

		ReportBodyBuilder bodyBuilder = new XMLReportBodyBuilder();
		ReportAssembler reportAssembler = new ReportAssembler();
		Report report;
		reportAssembler.setSaleEntry(createDummySaleEntry());
		report= reportAssembler.getReport(bodyBuilder);
		String expected = "<sale><customer><name>Bob</name><phone>1232232</phone></customer><items><item><name>Computer</name><quantity>2</quantity><price>99.9</price></item><item><name>Printer</name><quantity>1</quantity><price>79.8</price></item></items></sale>";

		assertEquals(expected, report.getAsString());

	}
	
	@Test
	public void testAssembleHTMLReportBody() {

		ReportBodyBuilder bodyBuilder = new HMTLReportBodyBuilder();
		ReportAssembler reportAssembler = new ReportAssembler();
		Report report;
		reportAssembler.setSaleEntry(createDummySaleEntry());
		report= reportAssembler.getReport(bodyBuilder);
		String expected = "<span class=\"customerName\">Bob</span><span class=\"customerPhone\">1232232</span><items><item><name>Computer</name><quantity>2</quantity><price>99.9</price></item><item><name>Printer</name><quantity>1</quantity><price>79.8</price></item></items>";

		assertEquals(expected, report.getAsString());

	}

	/**
	 * @return
	 */
	private SaleEntry createDummySaleEntry() {

		SaleEntry saleEntry = new SaleEntry();
		saleEntry.setCustomer(new Customer("Bob", "1232232"));
		saleEntry.addSoldItem(new SoldItem("Computer", 2, 99.9));
		saleEntry.addSoldItem(new SoldItem("Printer", 1, 79.8));

		return saleEntry;
	}

}
