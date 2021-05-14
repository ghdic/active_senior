package controller.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class PathListener implements ServletContextListener {
    public static ServletContext context;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        context = sce.getServletContext();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        context = null;
    }
}
