package eu.jpereira.trainings.designpatterns.creational.builder.xml;

import eu.jpereira.trainings.designpatterns.creational.builder.model.*;

import java.util.Iterator;

public class XMLReportBodyBuilder implements ReportBodyBuilder {

    private SaleEntry saleEntry;
    private XMLReportBody xmlReportBody;

    @Override
    public void setSaleEntry(SaleEntry saleEntry) {
        this.saleEntry=saleEntry;
    }

    @Override
    public ReportBody getReportBody() {
        xmlReportBody = new XMLReportBody();
        xmlReportBody.putContent("<sale><customer><name>");
        xmlReportBody.putContent(saleEntry.getCustomer().getName());
        xmlReportBody.putContent("</name><phone>");
        xmlReportBody.putContent(saleEntry.getCustomer().getPhone());
        xmlReportBody.putContent("</phone></customer>");

        xmlReportBody.putContent("<items>");

        Iterator<SoldItem> it = saleEntry.getSoldItems().iterator();
        while ( it.hasNext() ) {
            SoldItem soldEntry= it.next();
            xmlReportBody.putContent("<item><name>");
            xmlReportBody.putContent(soldEntry.getName());
            xmlReportBody.putContent("</name><quantity>");
            xmlReportBody.putContent(soldEntry.getQuantity());
            xmlReportBody.putContent("</quantity><price>");
            xmlReportBody.putContent(soldEntry.getUnitPrice());
            xmlReportBody.putContent("</price></item>");
        }
        xmlReportBody.putContent("</items></sale>");
        return  xmlReportBody;
    }
}
