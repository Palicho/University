package eu.jpereira.trainings.designpatterns.creational.builder.json;

import eu.jpereira.trainings.designpatterns.creational.builder.model.*;

import java.util.Iterator;

public class JSONReportBodyBuilder implements ReportBodyBuilder {
    SaleEntry saleEntry;
    JSONReportBody jsonReportBody;

    @Override
    public void setSaleEntry(SaleEntry saleEntry) {
        this.saleEntry=saleEntry;
    }

    @Override
    public ReportBody getReportBody() {
        jsonReportBody= new JSONReportBody();
        jsonReportBody.addContent("sale:{customer:{");
        jsonReportBody.addContent("name:\"");
        jsonReportBody.addContent(saleEntry.getCustomer().getName());
        jsonReportBody.addContent("\",phone:\"");
        jsonReportBody.addContent(saleEntry.getCustomer().getPhone());
        jsonReportBody.addContent("\"}");

        //jsonReportBody.add array of items
        jsonReportBody.addContent(",items:[");
        Iterator<SoldItem> it = saleEntry.getSoldItems().iterator();
        while ( it.hasNext() ) {
            SoldItem item = it.next();
            jsonReportBody.addContent("{name:\"");
            jsonReportBody.addContent(item.getName());
            jsonReportBody.addContent("\",quantity:");
            jsonReportBody.addContent(String.valueOf(item.getQuantity()));
            jsonReportBody.addContent(",price:");
            jsonReportBody.addContent(String.valueOf(item.getUnitPrice()));
            jsonReportBody.addContent("}");
            if ( it.hasNext() ) {
                jsonReportBody.addContent(",");
            }

        }
        jsonReportBody.addContent("]}");
        return jsonReportBody;
    }
}
