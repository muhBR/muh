package com.example.myos.ui.ui.product

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class ProductViewModel : ViewModel() {

    private val _text = MutableLiveData<String>().apply {
        value = "Tela de Produtos"
    }
    val text: LiveData<String> = _text
}
