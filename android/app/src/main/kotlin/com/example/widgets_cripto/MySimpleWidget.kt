package com.example.widgets_cripto

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews
import com.example.widgets_cripto.MainActivity
import com.bumptech.glide.Glide
import com.bumptech.glide.request.target.CustomTarget
import com.bumptech.glide.request.transition.Transition
import android.graphics.Bitmap
import android.graphics.drawable.Drawable

class MySimpleWidget : AppWidgetProvider() {

    companion object {
        private const val ACTION_REFRESH = "com.example.widgets_cripto.ACTION_REFRESH"
    }

    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        if (intent.action == ACTION_REFRESH) {
            val mgr = AppWidgetManager.getInstance(context)
            val cn = ComponentName(context, MySimpleWidget::class.java)
            val ids = mgr.getAppWidgetIds(cn)
            for (id in ids) updateAppWidget(context, mgr, id)
        }
    }

    private fun updateAppWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int) {
        val views = RemoteViews(context.packageName, R.layout.widget_layout)

        // Read saved crypto info from Flutter's SharedPreferences
        val prefsFlutter = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
        var stored = prefsFlutter.getString("crypto_price", null)
        if (stored == null) stored = prefsFlutter.getString("flutter.crypto_price", null)
        if (stored == null) {
            val prefsAlt = context.getSharedPreferences("widget_prefs", Context.MODE_PRIVATE)
            stored = prefsAlt.getString("crypto_price", "—")
        }

        var name = "—"
        var value = "—"
        if (stored != null && stored.contains(":")) {
            val parts = stored.split(":", limit = 2)
            name = parts[0].trim()
            value = parts[1].trim()
        } else if (stored != null) {
            value = stored
        }

        views.setTextViewText(R.id.tv_name, name)
        views.setTextViewText(R.id.tv_price, value)

        // Load icon from saved URL (try FlutterSharedPreferences first / fallback to widget_prefs)
        var imageUrl = prefsFlutter.getString("crypto_image", null)
        if (imageUrl == null) imageUrl = prefsFlutter.getString("flutter.crypto_image", null)
        if (imageUrl == null) imageUrl = context.getSharedPreferences("widget_prefs", Context.MODE_PRIVATE).getString("crypto_image", null)

        if (!imageUrl.isNullOrEmpty()) {
            try {
                // Use Glide to fetch a Bitmap and set it into the RemoteViews
                Glide.with(context.applicationContext)
                    .asBitmap()
                    .load(imageUrl)
                    .into(object : com.bumptech.glide.request.target.CustomTarget<android.graphics.Bitmap>() {
                        override fun onResourceReady(resource: android.graphics.Bitmap, transition: com.bumptech.glide.request.transition.Transition<in android.graphics.Bitmap>?) {
                            views.setImageViewBitmap(R.id.iv_icon, resource)
                            appWidgetManager.updateAppWidget(appWidgetId, views)
                        }

                        override fun onLoadCleared(placeholder: android.graphics.drawable.Drawable?) {}

                        override fun onLoadFailed(errorDrawable: android.graphics.drawable.Drawable?) {
                            // keep default icon if load fails
                            appWidgetManager.updateAppWidget(appWidgetId, views)
                        }
                    })
            } catch (e: Exception) {
                appWidgetManager.updateAppWidget(appWidgetId, views)
            }
        } else {
            // No image URL — keep default icon
            views.setImageViewResource(R.id.iv_icon, R.mipmap.ic_launcher)
        }

        // PendingIntent to refresh the widget
        val intentRefresh = Intent(context, MySimpleWidget::class.java).apply {
            action = ACTION_REFRESH
        }
        val pendingRefresh = PendingIntent.getBroadcast(
            context, 0, intentRefresh,
            PendingIntent.FLAG_UPDATE_CURRENT or (if (android.os.Build.VERSION.SDK_INT >= 31) PendingIntent.FLAG_IMMUTABLE else 0)
        )
        views.setOnClickPendingIntent(R.id.btn_refresh, pendingRefresh)

        // PendingIntent to open the app when user taps the name or price
        val intentOpen = Intent(context, MainActivity::class.java)
        val pendingOpen = PendingIntent.getActivity(
            context, 0, intentOpen,
            PendingIntent.FLAG_UPDATE_CURRENT or (if (android.os.Build.VERSION.SDK_INT >= 31) PendingIntent.FLAG_IMMUTABLE else 0)
        )
        views.setOnClickPendingIntent(R.id.tv_name, pendingOpen)
        views.setOnClickPendingIntent(R.id.tv_price, pendingOpen)

        appWidgetManager.updateAppWidget(appWidgetId, views)
    }
}
