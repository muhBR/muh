package com.example.myos.ui.ui.serviceorder

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.example.myos.R

class ServiceOrderFragment : Fragment() {

    private lateinit var serviceOrderViewModel: ServiceOrderViewModel

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        serviceOrderViewModel =
            ViewModelProvider(this).get(ServiceOrderViewModel::class.java)
        val root = inflater.inflate(R.layout.fragment_home, container, false)
        val textView: TextView = root.findViewById(R.id.text_home)
        serviceOrderViewModel.text.observe(
            viewLifecycleOwner,
            Observer {
                textView.text = it
            }
        )
        return root
    }
}
