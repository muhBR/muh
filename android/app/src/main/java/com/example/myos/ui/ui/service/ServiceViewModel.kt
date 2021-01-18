package com.example.myos.ui.ui.service

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class ServiceViewModel : ViewModel() {

    private val _text = MutableLiveData<String>().apply {
        value = "Tela  de serviços"
    }
    val text: LiveData<String> = _text
}
