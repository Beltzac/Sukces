package util;

import java.lang.reflect.InvocationTargetException;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.beanutils.BeanUtils;

public class FormUtil {

	public static <T> T populate(Class<T> clazz, HttpServletRequest request) {
		T object = null;
		try {

			object = (T) clazz.newInstance();
			BeanUtils.populate(object, request.getParameterMap());

		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		return object;
	}
}