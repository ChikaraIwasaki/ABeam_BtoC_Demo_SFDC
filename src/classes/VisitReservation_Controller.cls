/**
 * @File Name          : VisitReservation_Controller.cls
 * @Description        : 
 * @Author             : Tom Tanaka
 * @Group              : 
 * @Last Modified By   : Tom Tanaka
 * @Last Modified On   : 2019/10/24 17:39:07
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    2019/10/23   Tom Tanaka     Initial Version
**/
public class VisitReservation_Controller {
 
    public Boolean includeMyEvents {get;set;}
    public list<visitReserveInfo> events {get;set;}
     
    // 日付形式
    String dateFormat = 'EEE, yyyy MMM d HH:mm:ss z';
     
    // コンストラクター
    public VisitReservation_Controller() {
        // 自分のイベントをデフォルトで表示する
        includeMyEvents = true;
    }
     
    public PageReference pageLoad() {
        events = new list<visitReserveInfo>();
        // 顧客の連絡先
        for(VisitReservation__c visitReserve : [select Id, Name, Shop__c, IsAdmin__c, Na__c, From__c, To__c from VisitReservation__c where From__c != null and To__c != null]){
            visitReserveInfo vdt = new visitReserveInfo();
            System.debug('debug:xxxxx ' + visitReserve.Name);
             
            vdt.title = visitReserve.Name;
            vdt.allDay = visitReserve.Na__c;
            vdt.startString = visitReserve.From__c.format(dateFormat);

            vdt.endString = visitReserve.To__c.format(dateFormat);

            events.add(vdt);
        }
         
        return null;
    }
     
    public PageReference toggleMyEvents() {
        if(includeMyEvents){
            includeMyEvents = false;
        }
        else{
            includeMyEvents = true;
        }
        pageload();
        return null;
    }
 
     
    // 来店予約情報
    public class visitReserveInfo{
        public String title {get;set;}          // 来店予約名
        public String startString {get;set;}    // 予約開始時間
        public String endString {get;set;}      // 予約終了時間
        public Boolean allDay {get;set;}            // 予約フラグ
    }
}