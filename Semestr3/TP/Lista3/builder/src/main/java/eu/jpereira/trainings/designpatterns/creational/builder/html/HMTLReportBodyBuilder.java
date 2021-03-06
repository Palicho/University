package eu.jpereira.trainings.designpatterns.creational.builder.html;

import eu.jpereira.trainings.designpatterns.creational.builder.html.HTMLReportBody;
import eu.jpereira.trainings.designpatterns.creational.builder.model.*;

import java.util.Iterator;

public class HMTLReportBodyBuilder implements ReportBodyBuilder {

    private SaleEntry saleEntry;
    private HTMLReportBody htmlReportBody;

    @Override
    public void setSaleEntry(SaleEntry saleEntry) {
        this.saleEntry=saleEntry;
    }

    @Override
    public ReportBody getReportBody() {
        htmlReportBody= new HTMLReportBody();
        htmlReportBody.putContent("<span class=\"customerName\">");
        htmlReportBody.putContent(saleEntry.getCustomer().getName());
        htmlReportBody.putContent("</span><span class=\"customerPhone\">");
        htmlReportBody.putContent(saleEntry.getCustomer().getPhone());
        htmlReportBody.putContent("</span>");

        htmlReportBody.putContent("<items>");

        Iterator<SoldItem> it = saleEntry.getSoldItems().iterator();
        while ( it.hasNext() ) {
            SoldItem soldEntry= it.next();
            htmlReportBody.putContent("<item><name>");
            htmlReportBody.putContent(soldEntry.getName());
            htmlReportBody.putContent("</name><quantity>");
            htmlReportBody.putContent(soldEntry.getQuantity());
            htmlReportBody.putContent("</quantity><price>");
            htmlReportBody.putContent(soldEntry.getUnitPrice());
            htmlReportBody.putContent("</price></item>");
        }
        htmlReportBody.putContent("</items>");

        return htmlReportBody;
    }
}
