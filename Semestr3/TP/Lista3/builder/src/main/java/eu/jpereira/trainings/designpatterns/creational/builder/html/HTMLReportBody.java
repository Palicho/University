package eu.jpereira.trainings.designpatterns.creational.builder.html;

import eu.jpereira.trainings.designpatterns.creational.builder.model.ReportBody;
import eu.jpereira.trainings.designpatterns.creational.builder.model.SaleEntry;
import eu.jpereira.trainings.designpatterns.creational.builder.model.SoldItem;

import java.util.Iterator;

public class HTMLReportBody implements ReportBody {

	private StringBuffer delegate = new StringBuffer();

	@Override
	public Object getAsString() {
		return this.delegate .toString();
	}

	public void putContent(Object content) {
		this.delegate.append(content);
		
	}

}
