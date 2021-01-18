package com.example.myos.ui.ui.serviceorder

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class ServiceOrderViewModel : ViewModel() {

    private val _text = MutableLiveData<String>().apply {
        value = "Ordem de serviço"
    }
    val text: LiveData<String> = _text
}
