package ru.mobui.flutter_ble_server

import android.bluetooth.le.AdvertiseData
import android.bluetooth.le.AdvertiseSettings
import android.os.ParcelUuid
import org.json.JSONArray
import org.json.JSONObject
import java.util.*

class Advertiser(val settings: AdvertiseSettings, val data: AdvertiseData) {
    companion object {
        fun fromJson(json: JSONObject): Advertiser {

            val param = AdvertiseParam.parse(json)
            val settings = buildSettings(param.settings)
            val data = buildData(param.data)

            return Advertiser(settings, data)
        }

        private fun buildSettings(settings: AdvertiserSettings): AdvertiseSettings {
            return AdvertiseSettings.Builder()
                .setAdvertiseMode(settings.mode)
                .setConnectable(settings.connectable)
                .setTimeout(settings.timeout)
                .setTxPowerLevel(settings.txPowerLevel)
                .build()
        }

        private fun buildData(data: AdvertiserData): AdvertiseData {
            val dataBuilder = AdvertiseData.Builder()

            if (data.manufacturerData != null) {
                dataBuilder.addManufacturerData(
                    data.manufacturerData.manufacturerId,
                    data.manufacturerData.manufacturerSpecificData
                )
            }

            if (data.serviceUuid != null) {
                dataBuilder.addServiceUuid(
                    ParcelUuid(UUID.fromString(data.serviceUuid))
                )
            }

            if (data.serviceData != null) {
                dataBuilder.addServiceData(
                    ParcelUuid(UUID.fromString(data.serviceData.serviceDataUuid)),
                    data.serviceData.serviceData
                )
            }
            dataBuilder.setIncludeDeviceName(data.includeDeviceName)
            dataBuilder.setIncludeTxPowerLevel(data.includeTxPowerLevel)
            return dataBuilder.build();
        }
    }
}

data class AdvertiseParam(
    val settings: AdvertiserSettings,
    val data: AdvertiserData
) {
    companion object {
        fun parse(json: JSONObject): AdvertiseParam {
            //Settings
            val settings = json.getJSONObject("settings")

            val mode = settings.getInt("advertiseMode")
            val txPowerLevel = settings.getInt("txPowerLevel")
            val connectable = settings.getBoolean("connectable")
            val timeout = settings.getInt("timeout")

            // Data
            val data = json.getJSONObject("data")
            // Manufacturer
            var manufacturerData: ManufacturerData? = null
            if (data.has("manufacturerData")) {
                val manufacturer = data.getJSONObject("manufacturerData");
                val dataArray = manufacturer.getJSONArray("manufacturerSpecificData")

                manufacturerData = ManufacturerData(
                    manufacturer.getInt("manufacturerId"),
                    jsonToByteArray(dataArray)
                )
            }
            // Service
            var serviceUuid: String? = null
            if (data.has("serviceUuid")) {
                serviceUuid = data.getString("serviceUuid")
            }
            // Service Data
            var serviceData: ServiceData? = null
            if (data.has("")) {
                val service = data.getJSONObject("serviceData");
                val dataArray = service.getJSONArray("serviceData")
                serviceData = ServiceData(
                    service.getString("serviceDataUuid"),
                    jsonToByteArray(dataArray)
                )
            }

            return AdvertiseParam(
                settings = AdvertiserSettings(
                    mode,
                    txPowerLevel,
                    connectable,
                    timeout
                ),
                data = AdvertiserData(
                    manufacturerData,
                    serviceUuid,
                    serviceData
                )
            )
        }
    }
}


data class AdvertiserSettings(
    val mode: Int,
    val txPowerLevel: Int,
    val connectable: Boolean = true,
    val timeout: Int = 0
)

data class AdvertiserData(
    val manufacturerData: ManufacturerData?,
    val serviceUuid: String?,
    val serviceData: ServiceData?,
    val includeDeviceName: Boolean = false,
    val includeTxPowerLevel: Boolean = false
)

data class ManufacturerData(
    val manufacturerId: Int,
    val manufacturerSpecificData: ByteArray
)

data class ServiceData(
    val serviceDataUuid: String,
    val serviceData: ByteArray
)

fun jsonToByteArray(jsonArray: JSONArray): ByteArray {
    return Array(jsonArray.length()) { it ->
        jsonArray.getInt(it).toByte()
    }.toByteArray()
}