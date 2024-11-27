package com.example.mylabtest;

import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.example.mylabtest.databinding.ActivityMainBinding;

public class MainActivity extends AppCompatActivity {

    ActivityMainBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        // Button click listener to calculate total items
        binding.btnCalculate.setOnClickListener(this::calculateItem);
    }

    public void calculateItem(View view) {
        try {
            // Get the quantity values from the input fields
            int items1 = Integer.parseInt(binding.editPizza1Qty.getText().toString().trim());
            int items2 = Integer.parseInt(binding.editPizza2Qty.getText().toString().trim());

            // Calculate the total
            int itemCount = items1 + items2;
            int totalPrices = (items1 * 18) + (items2 * 22);

            // Update the TextView with the result
            binding.textItems.setText("Total Items: " + itemCount);
            binding.totalPrice.setText("Total Price to Pay : RM " + totalPrices);
        } catch (NumberFormatException e) {
            // Handle invalid input (e.g., empty fields or non-numeric input)
            Toast.makeText(this, "Please enter valid quantities!", Toast.LENGTH_SHORT).show();
        }
    }
}
