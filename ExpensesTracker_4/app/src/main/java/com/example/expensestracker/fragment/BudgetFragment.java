package com.example.expensestracker.fragment;

import android.app.DatePickerDialog;
import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.fragment.app.Fragment;

import com.example.expensestracker.HomePage;
import com.example.expensestracker.R;
import com.example.expensestracker.model.Budget;
import com.example.expensestracker.sqlite.DatabaseHelper;
import com.github.mikephil.charting.charts.BarChart;
import com.github.mikephil.charting.data.BarData;
import com.github.mikephil.charting.data.BarDataSet;
import com.github.mikephil.charting.data.BarEntry;
import com.google.android.material.bottomsheet.BottomSheetBehavior;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

public class BudgetFragment extends Fragment {

    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    private String mParam1;
    private String mParam2;

    private EditText targetBudgetEditText;
    private Button startDateButton;
    private Button endDateButton;
    private CheckBox notificationCheckBox;
    private Button saveBudgetButton;
    private TextView dateRangeTextView;
    private Calendar startDateCalendar;
    private Calendar endDateCalendar;
    private BottomSheetBehavior<View> bottomSheetBehavior;
    private DatabaseHelper dbBudget;  // Database helper
    private BarChart barChart; // Bar Chart
    private TextView budgetTargetLabelTextView; // TextView for budget target label
    private int loggedInUserId = -1;


    public BudgetFragment() {
        // Required empty public constructor
    }

    public static BudgetFragment newInstance(String param1, String param2) {
        BudgetFragment fragment = new BudgetFragment();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_budget, container, false);

        // Initialize DatabaseHelper
        dbBudget = new DatabaseHelper(getContext());

        // Retrieve logged-in user ID from SharedPreferences
        SharedPreferences sharedPreferences = requireActivity().getSharedPreferences("userPrefs", Context.MODE_PRIVATE);
        loggedInUserId = sharedPreferences.getInt("user_id", -1);
        if (loggedInUserId == -1) {
            // Handle case where no user is logged in
            Toast.makeText(getContext(), "User ID not found, please login again", Toast.LENGTH_LONG).show();
            // Consider navigating back to login screen
            return view; // Or return null, depending on navigation
        }


        FloatingActionButton fabBack = view.findViewById(R.id.fabBack);

        // Set onClickListener for the Budget Setting button
        fabBack.setOnClickListener(v -> navigateToBack());

        barChart = view.findViewById(R.id.budget_bar_chart); // Initialize barChart
        budgetTargetLabelTextView = view.findViewById(R.id.budget_target_label); // Initialize budgetTargetLabelTextView


        // Initialize BottomSheetBehavior
        View bottomSheet = view.findViewById(R.id.budget_setting_bottom_sheet);
        bottomSheetBehavior = BottomSheetBehavior.from(bottomSheet);
        bottomSheetBehavior.setState(BottomSheetBehavior.STATE_COLLAPSED);

        // Initialize UI elements
        targetBudgetEditText = view.findViewById(R.id.target_budget_edittext);
        startDateButton = view.findViewById(R.id.start_date_button);
        endDateButton = view.findViewById(R.id.end_date_button);
        notificationCheckBox = view.findViewById(R.id.notification_checkbox);
        saveBudgetButton = view.findViewById(R.id.save_budget_button);
        dateRangeTextView = view.findViewById(R.id.date_range_textview);

        startDateCalendar = Calendar.getInstance();
        endDateCalendar = Calendar.getInstance();

        // Date Picker for Start Date
        DatePickerDialog.OnDateSetListener startDateSetListener = (v, year, month, dayOfMonth) -> {
            startDateCalendar.set(Calendar.YEAR, year);
            startDateCalendar.set(Calendar.MONTH, month);
            startDateCalendar.set(Calendar.DAY_OF_MONTH, dayOfMonth);
            updateDateRangeTextView();
        };

        startDateButton.setOnClickListener(v -> new DatePickerDialog(getContext(), startDateSetListener,
                startDateCalendar.get(Calendar.YEAR),
                startDateCalendar.get(Calendar.MONTH),
                startDateCalendar.get(Calendar.DAY_OF_MONTH)).show());

        // Date Picker for End Date
        DatePickerDialog.OnDateSetListener endDateSetListener = (v, year, month, dayOfMonth) -> {
            endDateCalendar.set(Calendar.YEAR, year);
            endDateCalendar.set(Calendar.MONTH, month);
            endDateCalendar.set(Calendar.DAY_OF_MONTH, dayOfMonth);
            updateDateRangeTextView();
        };

        endDateButton.setOnClickListener(v -> new DatePickerDialog(getContext(), endDateSetListener,
                endDateCalendar.get(Calendar.YEAR),
                endDateCalendar.get(Calendar.MONTH),
                endDateCalendar.get(Calendar.DAY_OF_MONTH)).show());

        // Save Budget Button
        saveBudgetButton.setOnClickListener(v -> saveBudgetSettings());

        loadBudgetAndExpenses(); // Load budget and update chart on onCreateView

        return view;
    }


    private void navigateToBack() {
        SettingsFragment settingsFragment = new SettingsFragment();
        if (getActivity() instanceof HomePage) {
            ((HomePage) getActivity()).loadFragment(settingsFragment);
        }
    }

    private void updateDateRangeTextView() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.getDefault());
        String startDate = dateFormat.format(startDateCalendar.getTime());
        String endDate = dateFormat.format(endDateCalendar.getTime());
        dateRangeTextView.setText("Start Date: " + startDate + "\nEnd Date: " + endDate);
    }

    private void saveBudgetSettings() {
        String targetBudgetString = targetBudgetEditText.getText().toString();
        if (targetBudgetString.isEmpty()) {
            Toast.makeText(getContext(), "Please enter a target budget.", Toast.LENGTH_SHORT).show();
            return;
        }

        double targetBudget = Double.parseDouble(targetBudgetString);
        boolean enableNotifications = notificationCheckBox.isChecked();

        int userId = loadUserId();

        if (userId == -1) {
            Toast.makeText(getContext(), "User ID not found. Please login again.", Toast.LENGTH_SHORT).show();
            return;
        }

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.getDefault());
        String startDate = dateFormat.format(startDateCalendar.getTime());
        String endDate = dateFormat.format(endDateCalendar.getTime());

        Budget budget = new Budget();
        budget.setBudget_target(targetBudget);
        budget.setStart_date(startDate);
        budget.setEnd_date(endDate);
        budget.setUser_id(userId);

        try {
            dbBudget.addBudget(budget);
            Toast.makeText(getContext(), "Budget settings saved!", Toast.LENGTH_SHORT).show();

            targetBudgetEditText.setText("");
            notificationCheckBox.setChecked(false);
            updateDateRangeTextView();

            loadBudgetAndExpenses(); // Reload budget and update chart after saving

        } catch (Exception e) {
            Log.e("BudgetFragment", "Error saving budget: " + e.getMessage());
            Toast.makeText(getContext(), "Error saving budget.", Toast.LENGTH_SHORT).show();
        }
    }


    private void loadBudgetAndExpenses() {
        double budgetTarget = dbBudget.getBudgetForCurrentWeekForUser(loggedInUserId); // Get budget
        double totalExpensesCurrentWeek = dbBudget.getTotalExpenseForCurrentWeekForUser(loggedInUserId); // Get expenses

        budgetTargetLabelTextView.setText("Weekly Budget Target: RM " + String.format("%.2f", budgetTarget)); // Set budget target label

        List<BarEntry> entries = new ArrayList<>();
        entries.add(new BarEntry(0f, (float) budgetTarget)); // Budget bar
        entries.add(new BarEntry(1f, (float) totalExpensesCurrentWeek)); // Expenses bar

        BarDataSet dataSet = new BarDataSet(entries, "Budget vs Spending");
        dataSet.setColors(new int[]{Color.parseColor("#A5D6A7"), Color.parseColor("#EF9A9A")}); // Green for budget, Red for spending
        dataSet.setValueTextColor(Color.WHITE); // Value text color

        BarData barData = new BarData(dataSet);
        barChart.setData(barData);

        barChart.getXAxis().setValueFormatter(new com.github.mikephil.charting.formatter.IndexAxisValueFormatter(new String[]{"Budget", "Spending"})); // X-axis labels
        barChart.getXAxis().setTextColor(Color.WHITE);
        barChart.getAxisLeft().setTextColor(Color.WHITE); // Y-axis text color
        barChart.getAxisRight().setTextColor(Color.WHITE); // Y-axis right text color
        barChart.getLegend().setTextColor(Color.WHITE); // Legend text color

        barChart.getDescription().setEnabled(false);
        barChart.invalidate(); // Refresh chart

    }


    // Modified loadUserId to return userId from SharedPreferences
    public int loadUserId() {
        SharedPreferences sharedPreferences = getContext().getSharedPreferences("userPrefs", Context.MODE_PRIVATE);
        return sharedPreferences.getInt("user_id", -1); // -1 is default if not found
    }


    @Override
    public void onDestroy() {
        super.onDestroy();
        if (dbBudget != null) {
            dbBudget.close();
        }
    }

    public void showBottomSheet() {
        if (bottomSheetBehavior != null) {
            bottomSheetBehavior.setState(BottomSheetBehavior.STATE_EXPANDED);
        }
    }

    public void hideBottomSheet() {
        if (bottomSheetBehavior != null) {
            bottomSheetBehavior.setState(BottomSheetBehavior.STATE_COLLAPSED);
        }
    }
}