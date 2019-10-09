public class ParkLocator {
		public  static string[] country(String country) {
        ParkService.ParksImplPort prk = new ParkService.ParksImplPort();
        system.debug(prk.byCountry(country));
        return prk.byCountry(country);
    }
}