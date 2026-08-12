package lk.jiat.ElectroZone.service;

import com.google.gson.JsonObject;
import lk.jiat.ElectroZone.entity.City;
import lk.jiat.ElectroZone.util.AppUtil;
import lk.jiat.ElectroZone.util.HibernateUtil;
import org.hibernate.Session;

import java.util.List;

public class CityService {

    public String loadAllCities() {
        JsonObject responseObject = new JsonObject();

        /// city-loading-part-start
        Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
        List<City> cityList = hibernateSession.createQuery("FROM City c", City.class).getResultList();
        responseObject.add("cities", AppUtil.GSON.toJsonTree(cityList));
        hibernateSession.close();
        /// city-loading-part-end

        return AppUtil.GSON.toJson(responseObject);
    }
}
