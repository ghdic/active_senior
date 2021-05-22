package controller.tool;

import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
import java.util.Locale;

public class MethodManager {

    public static ArrayList<Method> findGetters(Class<?> c) {
        ArrayList<Method> list = new ArrayList<Method>();
        Method[] methods = c.getDeclaredMethods();
        for (Method method : methods)
            if (isGetter(method))
                list.add(method);
        return list;
    }

    public static ArrayList<Method> findSetters(Class<?> c) {
        ArrayList<Method> list = new ArrayList<Method>();
        Method[] methods = c.getDeclaredMethods();
        for (Method method : methods)
            if (isSetter(method))
                list.add(method);
        return list;
    }

    public static String getParamName(Method method) {
        return method.getName().substring(3, 4).toLowerCase() + method.getName().substring(4);
    }

    public static String getParamName(String method) {
        return method.substring(3, 4).toLowerCase() + method.substring(4);
    }

    public static String toSetMethodName(String name) {
        return "set" + name.substring(0, 1).toUpperCase() + name.substring(1);
    }

    public static String toGetMethodName(String name) {
        return "get" + name.substring(0, 1).toUpperCase() + name.substring(1);
    }

    public static boolean isGetter(Method method) {
        if (Modifier.isPublic(method.getModifiers()) &&
                method.getParameterTypes().length == 0) {
            if (method.getName().matches("^get[A-Z].*") &&
                    !method.getReturnType().equals(void.class))
                return true;
        }
        return false;
    }

    public static boolean isSetter(Method method) {
        return Modifier.isPublic(method.getModifiers()) &&
                method.getReturnType().equals(void.class) &&
                method.getParameterTypes().length == 1 &&
                method.getName().matches("^set[A-Z].*");
    }


    public static ArrayList<Method> getMethods(Class<?> c, ArrayList<String> methodName) {
        ArrayList<Method> list = new ArrayList<Method>();
        Method[] methods = c.getDeclaredMethods();
        for (Method method : methods)
            if (methodName.contains(method.getName()))
                list.add(method);
        return list;
    }

    public static ArrayList<String> getMethodNames(ArrayList<String> names) {
        ArrayList<String> list = new ArrayList<String>();
        for (String name : names)
            list.add(toGetMethodName(name));
        return list;
    }

    public static ArrayList<String> setMethodNames(ArrayList<String> names) {
        ArrayList<String> list = new ArrayList<String>();
        for (String name : names)
            list.add(toSetMethodName(name));
        return list;
    }
}
