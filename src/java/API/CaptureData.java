/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package API;

import static Security.Hashing.getShai256;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.charset.Charset;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Attr;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

/**
 *
 * @author IT-Programmer
 */
public class CaptureData {

    public static String RequestAPI(String Request, String Param) {
        String Response = "";
        String RequestTag = "";
        switch (Request) {
            case "GetMerchantTransactions":
                RequestTag = "ALB.Info cmd=\"LST-TXN\" " + Param;
                break;
            case "GetDashboardTotalCounts":
                RequestTag = "ALB.Info cmd=\"TOTAL-TXN\" " + Param;
                break;
            case "GetDashboardOverview":
                RequestTag = "ALB.Info cmd=\"YEAR-TXN\" " + Param;
                break;
            case "GetSomething":
                RequestTag = "ALB.Info cmd=\"DOWNDOC-APPEND\" " + Param;
                break;
        }
        try {
//            RequestTag = "ALB.Info cmd=\"LST-APPEND\"";

            String APIURL = "http://10.238.110.51:17010";//MBAPP
            String id = "f21b6c8de08967089e1dee783869134fe65fe854d84bc637968a04d718dc5c69";
            String SecretWord = "66a18cb24c00f2b713b4e70b4b0fe39defe0a5ff07fd883f80cb04f3840d0efe";

//            String APIURL = "http://10.232.237.10:17007";//PROD
//            String id = "2fa51f8d04ce9b2cd672f1d3318cdbb65b74556fc3a14afe7d2fffa6e1ebc085";//Prod
//            String SecretWord = "13a7c655a7d4213c0c7e77e83a7be6b267baa3f16937c401bf73371545cc9db8";//Prod

//            String APIURL = "http://10.0.0.121:17007";//JGB LOCAL
//            String id = "f21b6c8de08967089e1dee783869134fe65fe854d84bc637968a04d718dc5c69";
//            String SecretWord = "66a18cb24c00f2b713b4e70b4b0fe39defe0a5ff07fd883f80cb04f3840d0efe";
            String tdt = GetMytdt();
            String token = getShai256(id + SecretWord + tdt);
            String Tags = " "//;
                    + "id='" + id + "' "
                    + "tdt='" + tdt + "' "
                    + "token='" + token + "' ";
            System.out.println("ID: " + id);
            System.out.println("Secret: " + SecretWord);
            System.out.println("IP: " + APIURL);
            System.out.println("Token: " + token);
            String requestToAPI
                    = "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>"
                    + "    <Body>"
                    + "        <wb_Get_Info xmlns='http://tempuri.org/'>"
                    + "                            <XMLRequest>&lt;" + RequestTag + " " + Tags + "  /&gt;</XMLRequest>"
                    + "        </wb_Get_Info>"
                    + "    </Body>"
                    + "</Envelope>";

            URL url = new URL(APIURL);//AIP
            System.out.println(GetMytdt()+" - Request: " + requestToAPI);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();

            // Set timeout as per needs
            connection.setConnectTimeout(20000);
            connection.setReadTimeout(20000);

            // Set DoOutput to true if you want to use URLConnection for output.
            // Default is false
            connection.setDoOutput(true);

            connection.setUseCaches(true);
            connection.setRequestMethod("POST");

            // Set Headers
            connection.setRequestProperty("Accept", "application/xml");
            connection.setRequestProperty("Content-Type", "text/xml");
            connection.setRequestProperty("SoapAction", "http://tempuri.org/iWebInterface/wb_Get_Info");

            // Write XML
            OutputStream outputStream = connection.getOutputStream();
            byte[] b = requestToAPI.getBytes("UTF-8");
            outputStream.write(b);
            outputStream.flush();
            outputStream.close();
            String LogID = API.AuditLog.AddAuditLog(requestToAPI, APIURL);
            // Read XML
            InputStream inputStream = connection.getInputStream();

            byte[] res = new byte[2048];

            Reader inputStreamReader = new InputStreamReader(inputStream, Charset.forName("UTF-8"));
            StringBuilder responseFromAPI = new StringBuilder();
            int data = inputStreamReader.read();
            while (data != -1) {
                char theChar = (char) data;
                data = inputStreamReader.read();
                responseFromAPI.append(theChar);
            }

            inputStreamReader.close();
            Response = responseFromAPI.toString().replace("&lt;", "<").replace("&gt;", ">");
            // API.AuditLog.UpdateAPIResponse(LogID, Response);
            String ReturnCode = getResponseAttributesString(Response, "ALB.Info", "ReturnCode");
            String ErrorMsg = getResponseAttributesString(Response, "ALB.Info", "ErrorMsg");
            API.AuditLog.UpdateAPIResponse(LogID, "Return Code : " + ReturnCode + " ErrorMsg : " + ErrorMsg);

//          getResponseAttributes(responseFromAPI.toString().replace("&lt;", "<").replace("&gt;", ">"), "i");
//          System.out.println("Response : " + responseFromAPI);
//          String responseFromApi = responseFromAPI.toString().replace("&lt;", "<").replace("&gt;", ">");
        } catch (MalformedURLException ex) {
            Logger.getLogger(CaptureData.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(CaptureData.class.getName()).log(Level.SEVERE, null, ex);
        }
        return Response;
    }

    public static String GetMytdt() {
        //TimeZone tz = TimeZone.getTimeZone("UTC");
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSXXX"); // Quoted "Z" to indicate UTC, no timezone offset
        //df.setTimeZone(tz);
        String nowAsISO = df.format(new Date());
        System.out.println("tdt now: " + nowAsISO);
        return nowAsISO;
    }

    public static String getResponseAttributesString(String Response, String Node, String Attr) {
        final String xmlStr = Response;
        String AttrVal = "";
        //Use method to convert XML string content to XML Document object
        Document doc = convertStringToXMLDocument(xmlStr);
        //Verify XML document is build correctly
        doc.getDocumentElement().normalize();
        NodeList entries = doc.getElementsByTagName(Node);

        int num = entries.getLength();

        for (int i = 0; i < num; i++) {
            Element node = (Element) entries.item(i);
            System.out.println(node.getNodeValue());
            AttrVal += listSpecificAttributes(node, Attr);
        }
        return AttrVal;
    }

    public static String[][] getResponseAttributesArray(String Response, String Node) {
        final String xmlStr = Response;

        //Use method to convert XML string content to XML Document object
        Document doc = convertStringToXMLDocument(xmlStr);
        //Verify XML document is build correctly
        doc.getDocumentElement().normalize();
        NodeList entries = doc.getElementsByTagName(Node);

        int num = entries.getLength();
        String[][] AttrVal = new String[num][];
        System.out.println("No. of CIS:" + num);
        for (int i = 0; i < num; i++) {
            Element node = (Element) entries.item(i);
            AttrVal[i] = listAllAttributes(node);
        }
        return AttrVal;
    }

    public static String[][] getResponseAttributesArrayName(String Response, String Node) {
        final String xmlStr = Response;

        //Use method to convert XML string content to XML Document object
        Document doc = convertStringToXMLDocument(xmlStr);
        //Verify XML document is build correctly
        doc.getDocumentElement().normalize();
        NodeList entries = doc.getElementsByTagName(Node);

        int num = entries.getLength();

        String[][] AttrVal = new String[num][];
        System.out.println("No. of CIS:" + num);
        for (int i = 0; i < num; i++) {
            Element node = (Element) entries.item(i);
            AttrVal[i] = listAllAttributesNames(node);
        }
        return AttrVal;
    }

    public static String getResponseNodeString(String Response, String Node) {
        final String xmlStr = Response;
        String AttrVal = "";
        //Use method to convert XML string content to XML Document object
        Document doc = convertStringToXMLDocument(xmlStr);
        //Verify XML document is build correctly
        doc.getDocumentElement().normalize();

        AttrVal = doc.getElementsByTagName(Node).item(0).getTextContent();
        return AttrVal;
    }

    public static String listSpecificAttributes(Element element, String Attr) {
        String AttrVal = "";

        //System.out.println("List attributes for node: " + element.getNodeName());
        //GET VALUE OF SPECIFIC ATTRIBUTE
        AttrVal = element.getAttribute(Attr);

        return AttrVal;

    }

    public static String[] listAllAttributes(Element element) {
        //LIST ALL ATTRIBUTES
        // get a map containing the attributes of this node 
        NamedNodeMap attributes = element.getAttributes();

        // get the number of nodes in this map
        int numAttrs = attributes.getLength();

        int trueTransations = 0, mdr = 0;
        //false
//        for (int i = 0; i < numAttrs; i++) {
//            Attr attr = (Attr) attributes.item(i);
//            String attrValue = attr.getNodeValue();
//            String attrName = attr.getNodeName();
//
//            if (attrName.equals("tc_name")) {
//
//                if (attrValue.equals("MDR P2M Dr")) {
//                    mdr++;
//                } else {
//                    trueTransations++;
//                }
//            }
//
//        }
//
//        String[] AttrVal = new String[trueTransations];
//        System.out.println("No. of Attr:" + trueTransations);
//        for (int i = 0; i < trueTransations; i++) {
//            Attr attr = (Attr) attributes.item(i);
//
//            String attrName = attr.getNodeName();
//            String attrValue = attr.getNodeValue();
//            System.out.println(i + " : " + attrName + "=" + attrValue);
//            if (attrName.equals("tc_name")) {
//
//                if (attrValue.equals("MDR P2M Dr")) {
//
//                } else {
//                    AttrVal[i] = attrValue;
//                }
//            }
//
//            System.out.println("Found attribute: " + attrName + " with value: " + attrValue);
//
//        }
//true
        String[] AttrVal = new String[numAttrs];
        System.out.println("No. of Attr:" + numAttrs);
        for (int i = 0; i < numAttrs; i++) {
            Attr attr = (Attr) attributes.item(i);

            String attrName = attr.getNodeName();
            String attrValue = attr.getNodeValue();
            System.out.println(i + " : " + attrName + "=" + attrValue);
            AttrVal[i] = attrValue;
            //    System.out.println("Found attribute: " + attrName + " with value: " + attrValue);

        }
        System.out.println("True : " + trueTransations);
        System.out.println("MDR : " + mdr);
        return AttrVal;

    }

    public static String[] listAllAttributesNames(Element element) {

        //LIST ALL ATTRIBUTES
        // get a map containing the attributes of this node 
        NamedNodeMap attributes = element.getAttributes();

        // get the number of nodes in this map
        int numAttrs = attributes.getLength();
        //true
        String[] AttrVal = new String[numAttrs];
        System.out.println("No. of Attr:" + numAttrs);
        for (int i = 0; i < numAttrs; i++) {
            Attr attr = (Attr) attributes.item(i);

            String attrName = attr.getNodeName();
            String attrValue = attr.getNodeValue();
            System.out.println(i + " : " + attrName + "=" + attrValue);
            AttrVal[i] = attrName;
            //    System.out.println("Found attribute: " + attrName + " with value: " + attrValue);
        }

        int trueTransations = 0, mdr = 0;
//false
//        for (int i = 0; i < numAttrs; i++) {
//            Attr attr = (Attr) attributes.item(i);
//            String attrValue = attr.getNodeValue();
//            String attrName = attr.getNodeName();
//
//            if (attrName.equals("tc_name")) {
//
//                if (attrValue.equals("MDR P2M Dr")) {
//                    mdr++;
//                } else {
//                    trueTransations++;
//                }
//            }
//
//        }
//
//        String[] AttrVal = new String[trueTransations];
//        System.out.println("No. of Attr:" + trueTransations);
//        for (int i = 0; i < trueTransations; i++) {
//            Attr attr = (Attr) attributes.item(i);
//
//            String attrName = attr.getNodeName();
//            String attrValue = attr.getNodeValue();
//            System.out.println(i + " : " + attrName + "=" + attrValue);
//            if (attrName.equals("tc_name")) {
//
//                if (attrValue.equals("MDR P2M Dr")) {
//
//                } else {
//                    AttrVal[i] = attrName;
//                }
//            }
//
//            System.out.println("Found attribute: " + attrName + " with value: " + attrValue);
//
//        }
        System.out.println("True : " + trueTransations);
        System.out.println("MDR : " + mdr);
        return AttrVal;

    }

    public static String[] listAllAttributesCount(Element element) {//this is for getting the total transactions of the unit
        int Total = 0, pending = 0, success = 0, expired = 0;
        //LIST ALL ATTRIBUTES
        // get a map containing the attributes of this node 
        NamedNodeMap attributes = element.getAttributes();

        // get the number of nodes in this map
        int numAttrs = attributes.getLength();

        String[] AttrVal = new String[numAttrs];
        System.out.println("No. of Attr:" + numAttrs);
        for (int i = 0; i < numAttrs; i++) {
            Attr attr = (Attr) attributes.item(i);

            String attrName = attr.getNodeName();
            String attrValue = attr.getNodeValue();
            System.out.println(i + " : " + attrName + "=" + attrValue);
            AttrVal[i] = attrName;
            //    System.out.println("Found attribute: " + attrName + " with value: " + attrValue);
        }
        return AttrVal;

    }

    private static Document convertStringToXMLDocument(String xmlString) {
        //Parser that produces DOM object trees from XML content
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();

        //API to obtain DOM Document instance
        DocumentBuilder builder = null;
        try {
            //Create DocumentBuilder with default configuration
            builder = factory.newDocumentBuilder();

            //Parse the content to Document object
            Document doc = builder.parse(new InputSource(new StringReader(xmlString)));
            return doc;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
