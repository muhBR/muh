package com.example.myos.network

import android.content.Context
import com.apollographql.apollo.ApolloClient
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor

object Network {

    const val BASE_URL = "http://muhos.herokuapp.com/graphql"
    private var apClient: ApolloClient? = null
    private var httpClient: OkHttpClient? = null

    @JvmStatic
    fun getApolloClient(context: Context): ApolloClient? {

        // If Apollo Client is not null, return it else make a new Apollo Client.
        // Helps in singleton pattern.
        apClient?.let {
            return it
        } ?: kotlin.run {
            apClient = ApolloClient.builder()
                .okHttpClient(getOkhttpClient(context)!!)
                .serverUrl(BASE_URL)
                .build()
        }
        return apClient
    }

    private fun getOkhttpClient(context: Context): OkHttpClient? {
        val logging = HttpLoggingInterceptor()
        httpClient?.let {
            return it
        } ?: kotlin.run {
            httpClient = OkHttpClient.Builder()
                // Adding HttpLoggingInterceptor() to see the response body and the results.
                .addInterceptor(logging)
                .build()
        }
        return httpClient
    }
}
