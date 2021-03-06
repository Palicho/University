package eu.jpereira.trainings.designpatterns.structural.facade.model;

import eu.jpereira.trainings.designpatterns.structural.facade.BookstoreFacade;
import eu.jpereira.trainings.designpatterns.structural.facade.service.*;

public class DefaultBookstoreFacade implements BookstoreFacade {


    CustomerDBService customerDBService;
    protected BookDBService bookService;
    protected OrderingService orderingService;
    protected CustomerNotificationService customerNotificationService;
    protected WharehouseService warehouseService;

    Customer customer;
    Book book;
    Order order;
    DispatchReceipt dispatchReceipt;


    public DefaultBookstoreFacade(CustomerDBService customerDBService, BookDBService bookDBService, CustomerNotificationService customerNotificationService, OrderingService orderingService, WharehouseService warehouseService){
        super();
        this.customerDBService = customerDBService;
        this.customerNotificationService = customerNotificationService;
        this.orderingService = orderingService;
        this.warehouseService= warehouseService;
        this.bookService= bookDBService;
    }


    /**
     * @param customerId
     * @param isbn
     */
    @Override
    public void placeOrder(String customerId, String isbn) {
        book= bookService.findBookByISBN(isbn);
        customer=customerDBService.findCustomerById(customerId);
        order= orderingService.createOrder(customer,book);
        customerNotificationService.notifyClient(order);
        dispatchReceipt = warehouseService.dispatch(order);
        customerNotificationService.notifyClient(dispatchReceipt);
    }

}
