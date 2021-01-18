package com.example.myos.ui.ui.category

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class CategoryViewModel : ViewModel() {

    private val _text = MutableLiveData<String>().apply {
        value = "Tela  de categorias"
    }
    val text: LiveData<String> = _text
}
