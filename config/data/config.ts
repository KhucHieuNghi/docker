export const config = {
  WMC_URL: "http://localhost:4200/#/",
  WMC_RESET_PWD_URL: "http://localhost:4200/#/auth/reset-password?reset_pwd_token=",
  WMC_HOME_URL: "http://localhost:4200/#/pages/rooms",
  ACCESS_SECURITY_KEY: "mrbs@Supersecret!@#$9899qwe:,rtypo()^&;.inhgJHana",
  FORGOT_PWD_SECURITY_KEY: "forgot_pwd!@#$199qwe:,rtypo()^&;.inhgJHana_iu_dau",
  ACCESS_TOKEN_KEY: "x-access-token",
  X_API_KEY: "x-api-key",
  X_API_VAL: "mrbs_api_v1.0",
  WMC_CLIENT_KEY: "wmc-flag",
  WMC_CLIENT_VAL: "wmc_client",
  HW_CLIENT_VAL: "hw_client",
  RESET_PWD_TIMEOUT: 24, // unit is hour
  SYSTEM_EMAIL: "admin@mrbstest.com",
  SYSTEM_LOGIN: "MRBSFTTEST\\admin",
  WELCOME_EMAIL: "Welome@mrbstest.com",
  SYSTEM_EMAIL_PWD: "P@ssw0rd",
  SYSTEM_ADMIN_NAME: "Admin",
  SMTP_ADDRESS: "exch.mrbstest.com",
  SMTP_PORT: 25,
  SALT_LENGTH: 10,

  CATERING_AD_EMAIL: "cateringadmin@mrbstest.com",
  CATERING_AD_PASS: "P@ssw0rd",
  CATERING_AD_NAME: "Catering Admin",
  CATERING_ID_PREFIX: "PRMCT",

  EQUIP_AD_EMAIL: "equipadmin@mrbstest.com",
  EQUIP_AD_PASS: "P@ssw0rd",
  EQUIP_AD_NAME: "Equipment Admin",
  EQUIP_ID_PREFIX: "PRMEQ",

  // feature config
  IS_ENABLE_COUNT_AUTH_VIOLET: true,
  MAX_AUTH_VIOLET: 5, // if exceed will email to super admin and lock account
  AUTH_VIOLET_EXPIRE_DURATION: 3600, // seconds

  PRM_NAME: "PRM_SERVER.local",
  HUB_NAME: "HUBXX_SERVER.local",
  UUID: "406d47a6-2cee-4448-a7f5-05f27dee4600",
  UUID1: "PH8011EM",
  PANL_DEFAULT_VERSION: "2.2.2",
  PANL_FIRMWARE_PATH : "./firmware/PANL/",
  PANL_FIRMWARE_PREFIX: "PanL70_V",
  PANL_UPGRADE_BUFFER_SIZE: 256,
  LMLICENSEEXPIRED: -41,
  LMFINGERPRINTFILE: "/home/bridgetek/Projects/MRBS_Verification/Data/fingerprint",
  LMLOGINFEATURE: 529,
  LMLICENSEFILE: "/home/bridgetek/Projects/MRBS_Verification/Hub/uploads/license/TrialWare.v2c",
  LMSOFTWARE_WARRANTY_FEATURE: 530,
};
