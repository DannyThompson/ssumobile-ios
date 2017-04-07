package com.ssu385.blizzardconsumer.network;

import android.os.AsyncTask;

import com.squareup.okhttp.HttpUrl;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.Response;
import com.ssu385.blizzardconsumer.core.model.BossList;
import com.ssu385.blizzardconsumer.core.util.BossListParser;

import java.io.IOException;


public class BossListAsyncTask extends AsyncTask<String, String, BossList> {
    private BossListResponseListener listener;

    @Override
    protected BossList doInBackground(String... params) {
        OkHttpClient client = new OkHttpClient();

//        HttpUrl.Builder urlBuilder =
//              HttpUrl.parse(
//                  BlizzardConsumerApplication.
//                  getApplicationInstance().getBaseApiUrl() +
//                  BlizzardConsumerApplication.
//                  getApplicationInstance().getBossRouteExtension())
//               .newBuilder();
//
//        urlBuilder.addQueryParameter("apikey", BlizzardConsumerApplication.getApplicationInstance().getApiKey());
//        urlBuilder.addQueryParameter("locale",  BlizzardConsumerApplication.getApplicationInstance().getLocale());
//
//        String url = urlBuilder.build().toString();
//
//        Request request = new Request.Builder()
//                .url(url)
//                .build();
//
//        Response response = null;
//
//        try {
//            response = client.newCall(request).execute();
//
//            if (response != null) {//              return BossListParser.getBossListFromJson(response);
//            }
//        } catch (IOException e) {
//            // do something with exception
//        }

        return null;
    }

    @Override
    protected void onPostExecute(BossList bosses) {
        super.onPostExecute(bosses);

        listener.onBossListResponse(bosses);
    }

    public void setBossListResponseListener(BossListResponseListener listener){
        this.listener = listener;
    }

    public interface BossListResponseListener{
        void onBossListResponse(BossList bosses);
    }
}
